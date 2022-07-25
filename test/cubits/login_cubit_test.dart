import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:root_gorge/login/login.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  const validPhoneNumber = PhoneNumber.dirty('2178551977');
  const validSMSCode = SMSCode.dirty('123456');
  group(
    'LoginCubit',
    () {
      late AuthenticationRepository authenticationRepository;

      setUp(() {
        authenticationRepository = MockAuthenticationRepository();

        when(
          () => authenticationRepository.signInWithPhoneNumber(
            phoneNumber: any(named: 'phoneNumber'),
          ),
        ).thenAnswer((_) async {});

        when(
          () => authenticationRepository.confirmPhoneAuth(
            smsCode: any(named: 'smsCode'),
          ),
        ).thenAnswer((_) async {});
      });

      test('initial state is LoginState', () {
        expect(LoginCubit(authenticationRepository).state, const LoginState());
      });

      group(
        'phoneNumberChanged',
        () {
          blocTest<LoginCubit, LoginState>(
            'emits [valid]] when phone number is valid',
            build: () => LoginCubit(authenticationRepository),
            act: (cubit) => cubit.phoneNumberChanged('2178551977'),
            expect: () => const <LoginState>[
              LoginState(
                phoneNumber: PhoneNumber.dirty('2178551977'),
                status: FormzStatus.valid,
              )
            ],
          );
        },
      );

      group(
        'fullNameChanged',
        () {
          const mockFullName = 'John Doe';
          blocTest<LoginCubit, LoginState>(
            'emits [valid]] when full name is valid',
            build: () => LoginCubit(authenticationRepository),
            act: (cubit) => cubit.fullNameChanged(mockFullName),
            expect: () => const <LoginState>[
              LoginState(
                fullName: FullName.dirty(mockFullName),
                status: FormzStatus.valid,
              )
            ],
          );
        },
      );

      group(
        'smsCodeChanged',
        () {
          const mockSMSCode = '123456';
          blocTest<LoginCubit, LoginState>(
            'emits [valid]] when sms code is valid',
            build: () => LoginCubit(authenticationRepository),
            act: (cubit) => cubit.smsCodeChanged(mockSMSCode),
            expect: () => const <LoginState>[
              LoginState(
                smsCode: SMSCode.dirty(mockSMSCode),
                status: FormzStatus.valid,
              )
            ],
          );
        },
      );

      group(
        'logInWithPhoneNumber',
        () {
          blocTest<LoginCubit, LoginState>(
            'calls logInWithPhoneNumber with correct phone number',
            build: () => LoginCubit(authenticationRepository),
            seed: () => const LoginState(
              status: FormzStatus.valid,
              phoneNumber: validPhoneNumber,
            ),
            act: (cubit) => cubit.logInWithPhoneNumber(),
            verify: (_) {
              verify(
                () => authenticationRepository.signInWithPhoneNumber(
                  phoneNumber: '+1${validPhoneNumber.value}',
                ),
              ).called(1);
            },
          );

          blocTest<LoginCubit, LoginState>(
            'emits [submissionInProgress, submissionFailure] '
            'when logInWithPhoneNumber fails with SignInWithPhoneNumberFailure',
            setUp: () {
              when(
                () => authenticationRepository.signInWithPhoneNumber(
                  phoneNumber: '+11234567890',
                ),
              ).thenThrow(const SignInWithPhoneNumberFailure('oops'));
            },
            build: () => LoginCubit(authenticationRepository),
            seed: () => const LoginState(
              status: FormzStatus.valid,
              phoneNumber: PhoneNumber.dirty('1234567890'),
            ),
            act: (cubit) => cubit.logInWithPhoneNumber(),
            expect: () => const <LoginState>[
              LoginState(
                status: FormzStatus.submissionInProgress,
                phoneNumber: PhoneNumber.dirty('1234567890'),
              ),
              LoginState(
                status: FormzStatus.submissionFailure,
                phoneNumber: PhoneNumber.dirty('1234567890'),
                errorMessage: 'oops',
              )
            ],
          );

          blocTest<LoginCubit, LoginState>(
            'emits [submissionInProgress, submissionFailure] '
            'when logInWithPhoneNumber fails with Exception',
            setUp: () {
              when(
                () => authenticationRepository.signInWithPhoneNumber(
                  phoneNumber: '+11234567890',
                ),
              ).thenThrow(Exception('oops'));
            },
            build: () => LoginCubit(authenticationRepository),
            seed: () => const LoginState(
              status: FormzStatus.valid,
              phoneNumber: PhoneNumber.dirty('1234567890'),
            ),
            act: (cubit) => cubit.logInWithPhoneNumber(),
            expect: () => const <LoginState>[
              LoginState(
                status: FormzStatus.submissionInProgress,
                phoneNumber: PhoneNumber.dirty('1234567890'),
              ),
              LoginState(
                status: FormzStatus.submissionFailure,
                phoneNumber: PhoneNumber.dirty('1234567890'),
                errorMessage: 'oops',
              )
            ],
          );
        },
      );

      group(
        'logInWithSMSCode',
        () {
          blocTest<LoginCubit, LoginState>(
            'calls logInWithSMSCode with correct sms code',
            build: () => LoginCubit(authenticationRepository),
            seed: () => const LoginState(
              status: FormzStatus.valid,
              smsCode: validSMSCode,
            ),
            act: (cubit) => cubit.logInWithSMSCode(),
            verify: (_) {
              verify(
                () => authenticationRepository.confirmPhoneAuth(
                  smsCode: validSMSCode.value,
                ),
              ).called(1);
            },
          );

          blocTest<LoginCubit, LoginState>(
            'emits [submissionInProgress, submissionFailure] '
            'when logInWithSMSCode fails with ConfirmResultFailure',
            setUp: () {
              when(
                () => authenticationRepository.confirmPhoneAuth(
                  smsCode: 'ConfirmResultFailure',
                ),
              ).thenThrow(
                const ConfirmResultFailure('oops'),
              );
            },
            build: () => LoginCubit(authenticationRepository),
            seed: () => const LoginState(
              status: FormzStatus.valid,
              smsCode: SMSCode.dirty('ConfirmResultFailure'),
            ),
            act: (cubit) => cubit.logInWithSMSCode(),
            expect: () => const <LoginState>[
              LoginState(
                status: FormzStatus.submissionInProgress,
                smsCode: SMSCode.dirty('ConfirmResultFailure'),
              ),
              LoginState(
                status: FormzStatus.submissionFailure,
                smsCode: SMSCode.dirty('ConfirmResultFailure'),
                errorMessage: 'oops',
              )
            ],
          );

          blocTest<LoginCubit, LoginState>(
            'emits [submissionInProgress, submissionFailure] '
            'when logInWithSMSCode fails with Exception',
            setUp: () {
              when(
                () => authenticationRepository.confirmPhoneAuth(
                  smsCode: 'Exception',
                ),
              ).thenThrow(Exception('oops'));
            },
            build: () => LoginCubit(authenticationRepository),
            seed: () => const LoginState(
              status: FormzStatus.valid,
              smsCode: SMSCode.dirty('Exception'),
            ),
            act: (cubit) => cubit.logInWithSMSCode(),
            expect: () => const <LoginState>[
              LoginState(
                status: FormzStatus.submissionInProgress,
                smsCode: SMSCode.dirty('Exception'),
              ),
              LoginState(
                status: FormzStatus.submissionFailure,
                smsCode: SMSCode.dirty('Exception'),
                errorMessage: 'oops',
              )
            ],
          );
        },
      );
    },
  );
}
