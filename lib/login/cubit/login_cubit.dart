import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  void phoneNumberChanged(String value) {
    final phoneNumber = PhoneNumber.dirty(value);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        status: Formz.validate([phoneNumber]),
      ),
    );
  }

  void fullNameChanged(String value) {
    final fullName = FullName.dirty(value);
    emit(
      state.copyWith(
        fullName: fullName,
        status: Formz.validate([fullName]),
      ),
    );
  }

  void smsCodeChanged(String value) {
    final smsCode = SMSCode.dirty(value);
    emit(
      state.copyWith(
        smsCode: smsCode,
        status: Formz.validate([smsCode]),
      ),
    );
  }

  Future<void> logInWithPhoneNumber() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository
          .signInWithPhoneNumber('+1${state.phoneNumber}');
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignInWithPhoneNumberFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }

  Future<void> logInWithSMSCode() async {
    try {
      await _authenticationRepository.confirmPhoneAuth(state.smsCode.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignInWithPhoneNumberFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }
}
