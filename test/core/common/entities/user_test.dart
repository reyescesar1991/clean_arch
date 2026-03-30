import 'package:app_clean_arch/core/common/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User Entity', () {
    test('should create User with correct properties', () {
      const id = '1';
      const name = 'Test User';
      const email = 'test@test.com';

      final user = User(id: id, name: name, email: email);

      expect(user.id, id);
      expect(user.name, name);
      expect(user.email, email);
    });

    test('should create a copy with updated id', () {
      const originalId = '1';
      const newId = '2';
      const name = 'Test User';
      const email = 'test@test.com';

      final user = User(id: originalId, name: name, email: email);
      final copiedUser = user.copyWith(id: newId);

      expect(copiedUser.id, newId);
      expect(copiedUser.name, name);
      expect(copiedUser.email, email);
    });

    test('should create a copy with updated name', () {
      const id = '1';
      const originalName = 'Test User';
      const newName = 'Updated User';
      const email = 'test@test.com';

      final user = User(id: id, name: originalName, email: email);
      final copiedUser = user.copyWith(name: newName);

      expect(copiedUser.id, id);
      expect(copiedUser.name, newName);
      expect(copiedUser.email, email);
    });

    test('should create a copy with updated email', () {
      const id = '1';
      const name = 'Test User';
      const originalEmail = 'test@test.com';
      const newEmail = 'new@test.com';

      final user = User(id: id, name: name, email: originalEmail);
      final copiedUser = user.copyWith(email: newEmail);

      expect(copiedUser.id, id);
      expect(copiedUser.name, name);
      expect(copiedUser.email, newEmail);
    });

    test('should create a copy with multiple updated fields', () {
      const originalId = '1';
      const originalName = 'Test User';
      const originalEmail = 'test@test.com';
      const newId = '2';
      const newName = 'Updated User';
      const newEmail = 'new@test.com';

      final user = User(
        id: originalId,
        name: originalName,
        email: originalEmail,
      );
      final copiedUser = user.copyWith(
        id: newId,
        name: newName,
        email: newEmail,
      );

      expect(copiedUser.id, newId);
      expect(copiedUser.name, newName);
      expect(copiedUser.email, newEmail);
    });

    test(
      'should preserve original values when copyWith is called without parameters',
      () {
        const id = '1';
        const name = 'Test User';
        const email = 'test@test.com';

        final user = User(id: id, name: name, email: email);
        final copiedUser = user.copyWith();

        expect(copiedUser.id, id);
        expect(copiedUser.name, name);
        expect(copiedUser.email, email);
      },
    );
  });
}
