import 'package:app_clean_arch/core/common/entities/user.dart';
import 'package:app_clean_arch/core/error/failuires.dart';
import 'package:app_clean_arch/feature/auth/domain/repository/auth_repository.dart';
import 'package:app_clean_arch/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late UserSignUp userSignUp;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    userSignUp = UserSignUp(mockAuthRepository);
  });

  const tEmail = 'test@test.com';
  const tPassword = 'password123';
  const tName = 'Test User';
  final tUser = User(id: '1', name: tName, email: tEmail);

  group('UserSignUp', () {
    test('should call signUpWithEmailPassword from repository', () async {
      when(
        () => mockAuthRepository.signUpWithEmailPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) async => Right(tUser));

      final result = await userSignUp(
        UserSignUpParams(email: tEmail, password: tPassword, name: tName),
      );

      expect(result, Right(tUser));
      verify(
        () => mockAuthRepository.signUpWithEmailPassword(
          email: tEmail,
          password: tPassword,
          name: tName,
        ),
      ).called(1);
    });

    test('should return Failure when repository fails', () async {
      final tFailure = Failure('Sign up failed');
      when(
        () => mockAuthRepository.signUpWithEmailPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) async => Left(tFailure));

      final result = await userSignUp(
        UserSignUpParams(email: tEmail, password: tPassword, name: tName),
      );

      expect(result, Left(tFailure));
    });
  });
}
