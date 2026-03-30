import 'package:app_clean_arch/core/common/entities/user.dart';
import 'package:app_clean_arch/core/error/failuires.dart';
import 'package:app_clean_arch/core/usecase/usecase.dart';
import 'package:app_clean_arch/feature/auth/domain/repository/auth_repository.dart';
import 'package:app_clean_arch/feature/auth/domain/usecases/current_user.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late CurrentUser currentUser;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    currentUser = CurrentUser(mockAuthRepository);
  });

  final tUser = User(id: '1', name: 'Test User', email: 'test@test.com');

  group('CurrentUser', () {
    test('should call currentUser from repository', () async {
      when(
        () => mockAuthRepository.currentUser(),
      ).thenAnswer((_) async => Right(tUser));

      final result = await currentUser(NoParams());

      expect(result, Right(tUser));
      verify(() => mockAuthRepository.currentUser()).called(1);
    });

    test('should return Failure when repository fails', () async {
      final tFailure = Failure('No user logged in');
      when(
        () => mockAuthRepository.currentUser(),
      ).thenAnswer((_) async => Left(tFailure));

      final result = await currentUser(NoParams());

      expect(result, Left(tFailure));
    });
  });
}
