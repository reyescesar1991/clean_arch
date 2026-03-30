import 'package:app_clean_arch/core/common/entities/user.dart';
import 'package:app_clean_arch/core/error/failuires.dart';
import 'package:app_clean_arch/feature/auth/domain/repository/auth_repository.dart';
import 'package:app_clean_arch/feature/auth/domain/usecases/user_login.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late UserLogin userLogin;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    userLogin = UserLogin(mockAuthRepository);
  });

  const tEmail = 'test@test.com';
  const tPassword = 'password123';
  final tUser = User(id: '1', name: 'Test User', email: tEmail);

  group('UserLogin', () {
    test('should call loginWithEmailPassword from repository', () async {
      when(
        () => mockAuthRepository.loginWithEmailPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => Right(tUser));

      final result = await userLogin(
        UserLoginParams(email: tEmail, password: tPassword),
      );

      expect(result, Right(tUser));
      verify(
        () => mockAuthRepository.loginWithEmailPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
    });

    test('should return Failure when repository fails', () async {
      final tFailure = Failure('Login failed');
      when(
        () => mockAuthRepository.loginWithEmailPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => Left(tFailure));

      final result = await userLogin(
        UserLoginParams(email: tEmail, password: tPassword),
      );

      expect(result, Left(tFailure));
    });
  });
}
