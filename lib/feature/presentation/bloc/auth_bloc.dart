import 'package:app_clean_arch/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:app_clean_arch/core/usecase/usecase.dart';
import 'package:app_clean_arch/core/common/entities/user.dart';
import 'package:app_clean_arch/feature/domain/usecases/current_user.dart';
import 'package:app_clean_arch/feature/domain/usecases/user_login.dart';
import 'package:app_clean_arch/feature/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  // Bloc que controla el estado de la autenticación
  AuthBloc({
    required UserLogin userLogin,
    required UserSignUp userSignUp,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  }) : _userSignUp = userSignUp,
       _userLogin = userLogin,
       _currentUser = currentUser,
       _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));

    on<AuthSignUpEvent>(_onAuthSignUp);

    on<AuthLoginEvent>(_onAuthLogin);

    on<AuthIsUserLoggedInEvent>(_isUserLoggedIn);
  }

  void _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    // Llamamos al usecase y obtenemos el resultado
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );

    // Dependiendo del resultado, emitimos el estado correspondiente
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    // Llamamos al usecase y obtenemos el resultado
    final res = await _userLogin(
      UserLoginParams(email: event.email, password: event.password),
    );

    // Dependiendo del resultado, emitimos el estado correspondiente
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      // Si no hay error, emitimos el estado de autenticación exitosa
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  // Emitimos el estado de autenticación exitosa y actualizamos el cubit de usuario
  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    emit(AuthSuccess(user: user));
    _appUserCubit.updateUser(user);
  }
}
