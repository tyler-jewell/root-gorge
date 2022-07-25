part of 'login_cubit.dart';

enum LoginStatus {
  inProgress,
  gettingSMSCode,
  failure,
  completed,
}

class LoginState extends Equatable {
  const LoginState({
    this.phoneNumber = const phoneNumber.pure(),
    this.fullName = '',
    this.smsCode = '',
    this.status = LoginStatus.inProgress,
    this.errorMessage = '',
  });

  final String phoneNumber;
  final String fullName;
  final LoginStatus status;
  final String errorMessage;
  final String smsCode;

  @override
  List<Object> get props => [
        phoneNumber,
        fullName,
        status,
        errorMessage,
        smsCode,
      ];

  LoginState copyWith({
    String? phoneNumber,
    String? fullName,
    LoginStatus? status,
    String? errorMessage,
    String? smsCode,
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
