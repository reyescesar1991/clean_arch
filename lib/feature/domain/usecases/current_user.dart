import 'package:app_clean_arch/core/error/failuires.dart';
import 'package:app_clean_arch/core/usecase/usecase.dart';
import 'package:app_clean_arch/core/common/entities/user.dart';
import 'package:app_clean_arch/feature/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UserCase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
