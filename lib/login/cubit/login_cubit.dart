import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  void phoneNumberChanged(String value) {
    final phoneNumber = PhoneNumber.dirty(value);
    emit(state.copyWith(phoneNumber: value));
  }

  void fullNameChanged(String value) {
    emit(state.copyWith(fullName: value));
  }

  void smsCodeChanged(String value) {
    emit(state.copyWith(smsCode: value));
  }

  Future<void> logInWithPhoneNumber() async {
    emit(state.copyWith(status: LoginStatus.inProgress));
    try {
      await _authenticationRepository
          .signInWithPhoneNumber('+1${state.phoneNumber}');
      emit(state.copyWith(status: LoginStatus.gettingSMSCode));
    } on SignInWithPhoneNumberFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: LoginStatus.failure,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: LoginStatus.failure,
        ),
      );
    }
  }

  Future<void> logInWithSMSCode() async {
    try {
      await _authenticationRepository.confirmPhoneAuth(state.smsCode);
      emit(state.copyWith(status: LoginStatus.completed));
    } on SignInWithPhoneNumberFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: LoginStatus.failure,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: LoginStatus.failure,
        ),
      );
    }
  }
}
