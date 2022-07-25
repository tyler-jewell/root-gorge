import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:root_gorge/login/login.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  // const validPhoneNumber = '2178551977';

  group('LoginCubit', () {
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
    });

    test('initial state is LoginState', () {
      expect(LoginCubit(authenticationRepository).state, const LoginState());
    });

    group('phoneNumberChanged', () {
      blocTest<LoginCubit, LoginState>(
        'emits [valid]] when phone number is valid',
        build: () => LoginCubit(authenticationRepository),
        act: (cubit) => cubit.phoneNumberChanged('2178551977'),
        expect: () => const <LoginState>[LoginState(phoneNumber: '2178551977')],
      );
    });
  });
}
