part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.phoneNumber = const PhoneNumber.pure(),
    this.fullName = const FullName.pure(),
    this.smsCode = const SMSCode.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage = '',
  });

  final PhoneNumber phoneNumber;
  final FullName fullName;
  final FormzStatus status;
  final String errorMessage;
  final SMSCode smsCode;

  @override
  List<Object> get props => [
        phoneNumber,
        fullName,
        errorMessage,
        status,
        smsCode,
      ];

  LoginState copyWith({
    PhoneNumber? phoneNumber,
    FullName? fullName,
    FormzStatus? status,
    String? errorMessage,
    SMSCode? smsCode,
  }) {
    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      smsCode: smsCode ?? this.smsCode,
    );
  }
}
