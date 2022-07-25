import 'package:formz/formz.dart';

/// Validation errors for the [FullName] [FormzInput].
enum FullNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template full_name}
/// Form input for an full name input.
/// {@endtemplate}
class FullName extends FormzInput<String, FullNameValidationError> {
  /// {@macro ull name}
  const FullName.pure() : super.pure('');

  /// {@macro ull name}
  const FullName.dirty([String value = '']) : super.dirty(value);

  static final RegExp _fullNameRegExp = RegExp(
    '^[A-Za-z]',
  );

  @override
  FullNameValidationError? validator(String? value) {
    return _fullNameRegExp.hasMatch(value ?? '')
        ? null
        : FullNameValidationError.invalid;
  }
}
