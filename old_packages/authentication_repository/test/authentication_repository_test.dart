import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock.dart';

const _mockFirebaseUserUid = 'mock-uid';
const _mockFirebaseUserEmail = 'mock-email';

mixin LegacyEquality {
  @override
  bool operator ==(dynamic other) => false;

  @override
  int get hashCode => 0;
}

class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

class MockFirebaseUser extends Mock implements firebase_auth.User {}

class MockUserCredential extends Mock implements firebase_auth.UserCredential {}

class MockConfirmationResult extends Mock
    implements firebase_auth.ConfirmationResult {}

class FakeAuthCredential extends Fake implements firebase_auth.AuthCredential {}

class FakeAuthProvider extends Fake implements AuthProvider {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseAuthMocks();

  TestWidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  const phoneNumber = '+12178551977';
  const user = User(
    id: _mockFirebaseUserUid,
    email: _mockFirebaseUserEmail,
  );

  group('AuthenticationRepository', () {
    late firebase_auth.FirebaseAuth firebaseAuth;
    late AuthenticationRepository authenticationRepository;

    setUpAll(() {
      registerFallbackValue(FakeAuthCredential());
      registerFallbackValue(FakeAuthProvider());
    });

    setUp(() {
      firebaseAuth = MockFirebaseAuth();
      authenticationRepository = AuthenticationRepository(
        firebaseAuth: firebaseAuth,
      );
    });

    test('creates FirebaseAuth instance internally when not injected', () {
      expect(AuthenticationRepository.new, isNot(throwsException));
    });

    group('signInWithPhoneNumber', () {
      setUp(() {
        when(
          () => firebaseAuth.signInWithPhoneNumber(any()),
        ).thenAnswer((_) => Future.value(MockConfirmationResult()));
      });

      test('calls signInWithPhoneNumber', () async {
        await authenticationRepository.signInWithPhoneNumber(phoneNumber);
        verify(
          () => firebaseAuth.signInWithPhoneNumber(phoneNumber),
        ).called(1);
      });

      test('succeeds when createUserWithEmailAndPassword succeeds', () async {
        expect(
          authenticationRepository.signInWithPhoneNumber(phoneNumber),
          completes,
        );
      });

      test(
          'throws SignInWithPhoneNumberFailure '
          'when signInWithPhoneNumber throws', () async {
        when(
          () => firebaseAuth.signInWithPhoneNumber(any()),
        ).thenThrow(Exception());
        expect(
          authenticationRepository.signInWithPhoneNumber(phoneNumber),
          throwsA(isA<SignInWithPhoneNumberFailure>()),
        );
      });
    });

    group('logOut', () {
      test('calls signOut', () async {
        when(() => firebaseAuth.signOut()).thenAnswer((_) async {});
        await authenticationRepository.logOut();
        verify(() => firebaseAuth.signOut()).called(1);
      });

      test('throws LogOutFailure when signOut throws', () async {
        when(() => firebaseAuth.signOut()).thenThrow(Exception());
        expect(
          authenticationRepository.logOut(),
          throwsA(isA<LogOutFailure>()),
        );
      });
    });

    group('user', () {
      test('emits User.empty when firebase user is null', () async {
        when(() => firebaseAuth.authStateChanges())
            .thenAnswer((_) => Stream.value(null));
        await expectLater(
          authenticationRepository.user,
          emitsInOrder(const <User>[User.empty]),
        );
      });

      test('emits User when firebase user is not null', () async {
        final firebaseUser = MockFirebaseUser();
        when(() => firebaseUser.uid).thenReturn(_mockFirebaseUserUid);
        when(() => firebaseUser.email).thenReturn(_mockFirebaseUserEmail);
        when(() => firebaseUser.photoURL).thenReturn(null);
        when(() => firebaseAuth.authStateChanges())
            .thenAnswer((_) => Stream.value(firebaseUser));
        await expectLater(
          authenticationRepository.user,
          emitsInOrder(const <User>[user]),
        );
      });
    });

    group('currentUser', () {
      test('returns User.empty when cached user is null', () {
        expect(
          authenticationRepository.currentUser,
          equals(User.empty),
        );
      });

      test('returns User when cached user is not null', () async {
        expect(authenticationRepository.currentUser, equals(user));
      });
    });
  });
}
