import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';

void main() {
  group('Email', () {
    test('pure email is valid by default before touch', () {
      const email = Email.pure();
      expect(email.value, '');
      expect(email.isPure, true);
    });

    test('valid email string returns null validation error', () {
      const email = Email.dirty('test@example.com');
      expect(email.validator(email.value), isNull);
      expect(email.isValid, true);
    });

    test('empty email string returns empty validation error', () {
      const email = Email.dirty('');
      expect(email.validator(email.value), EmailValidationError.empty);
      expect(email.isValid, false);
    });

    test('invalid email format returns invalid error', () {
      const email = Email.dirty('not-an-email');
      expect(email.validator(email.value), EmailValidationError.invalid);
      expect(email.isValid, false);
    });
  });

  group('Password', () {
    test('pure password is valid by default before touch', () {
      const password = Password.pure();
      expect(password.value, '');
      expect(password.isPure, true);
    });

    test('password >= 6 characters is valid', () {
      const password = Password.dirty('123456');
      expect(password.validator(password.value), isNull);
      expect(password.isValid, true);
    });

    test('password < 6 characters returns tooShort', () {
      const password = Password.dirty('123');
      expect(password.validator(password.value), PasswordValidationError.tooShort);
      expect(password.isValid, false);
    });

    test('empty password returns empty', () {
      const password = Password.dirty('');
      expect(password.validator(password.value), PasswordValidationError.empty);
      expect(password.isValid, false);
    });
  });
}
