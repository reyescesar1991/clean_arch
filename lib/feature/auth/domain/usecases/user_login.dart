import 'package:app_clean_arch/core/error/failuires.dart';
import 'package:app_clean_arch/core/usecase/usecase.dart';
import 'package:app_clean_arch/core/common/entities/user.dart';
import 'package:app_clean_arch/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UserCase<User, UserLoginParams> {
  final AuthRepository _authRepository;

  UserLogin(this._authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await _authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
