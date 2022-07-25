import 'package:formz/formz.dart';

/// Validation errors for the [PhoneNumber] [FormzInput].
enum PhoneNumberValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template phone_number}
/// Form input for an phone number input.
/// {@endtemplate}
class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  /// {@macro phone number}
  const PhoneNumber.pure() : super.pure('');

  /// {@macro phone number}
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  static final RegExp _phoneNumberRegExp = RegExp(
    r'^[1-9]\d{2}\d{3}\d{4}',
  );

  @override
  PhoneNumberValidationError? validator(String? value) {
    return _phoneNumberRegExp.hasMatch(value ?? '')
        ? null
        : PhoneNumberValidationError.invalid;
  }
}
