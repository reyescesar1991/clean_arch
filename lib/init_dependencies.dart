import 'package:app_clean_arch/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:app_clean_arch/core/secrets/app_secrets.dart';
import 'package:app_clean_arch/feature/data/datasources/auth_remote_data_source.dart';
import 'package:app_clean_arch/feature/data/repositories/auth_repository_impl.dart';
import 'package:app_clean_arch/feature/domain/repository/auth_repository.dart';
import 'package:app_clean_arch/feature/domain/usecases/current_user.dart';
import 'package:app_clean_arch/feature/domain/usecases/user_login.dart';
import 'package:app_clean_arch/feature/domain/usecases/user_sign_up.dart';
import 'package:app_clean_arch/feature/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    //DataSource
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    //Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    //UseCases
    ..registerFactory<UserSignUp>(() => UserSignUp(serviceLocator()))
    ..registerFactory<UserLogin>(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    //Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
