import 'package:formz/formz.dart';

/// Validation errors for the [SMSCode] [FormzInput].
enum SMSCodeValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template sms_code}
/// Form input for an sms code input.
/// {@endtemplate}
class SMSCode extends FormzInput<String, SMSCodeValidationError> {
  /// {@macro sms code}
  const SMSCode.pure() : super.pure('');

  /// {@macro sms code}
  const SMSCode.dirty([String value = '']) : super.dirty(value);

  static final RegExp _smsCodeRegExp = RegExp(
    r'^[0-9]{1,6}$',
  );

  @override
  SMSCodeValidationError? validator(String? value) {
    return _smsCodeRegExp.hasMatch(value ?? '')
        ? null
        : SMSCodeValidationError.invalid;
  }
}
