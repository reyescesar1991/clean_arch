import 'package:app_clean_arch/core/error/failuires.dart';
import 'package:app_clean_arch/core/usecase/usecase.dart';
import 'package:app_clean_arch/core/common/entities/user.dart';
import 'package:app_clean_arch/feature/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UserCase<User, UserSignUpParams> {
  final AuthRepository _authRepository;

  UserSignUp(this._authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await _authRepository.signUpWithEmailPassword(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
