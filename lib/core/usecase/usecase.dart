import 'package:app_clean_arch/core/error/failuires.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
