import 'dart:async';
import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:meta/meta.dart';

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template sign_in_with_phone_number_failure}
/// Thrown if during the sign up process if a failure occurs.
/// {@endtemplate}
class SignInWithPhoneNumberFailure implements Exception {
  /// {@macro sign_in_with_phone_number_failure}
  const SignInWithPhoneNumberFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory SignInWithPhoneNumberFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-phone-number':
        return const SignInWithPhoneNumberFailure(
          'Phone number is invalid!',
        );
      default:
        return const SignInWithPhoneNumberFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template confirm_result_failure}
/// Thrown if during the sign up process if a failure occurs.
/// {@endtemplate}
class ConfirmResultFailure implements Exception {
  /// {@macro confirm_result_failure}
  const ConfirmResultFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory ConfirmResultFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-verification-code':
        return const ConfirmResultFailure(
          'Verification code invalid!',
        );
      default:
        return const ConfirmResultFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  late firebase_auth.ConfirmationResult confirmationResult;

  /// Whether or not the current environment is web
  /// Should only be overriden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  @visibleForTesting
  bool isWeb = kIsWeb;

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      return user;
    });
  }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  User get currentUser {
    return _firebaseAuth.currentUser?.toUser ?? User.empty;
    // return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  /// Creates a new user with the provided [phoneNumber].
  ///
  /// Throws a [SignInWithPhoneNumberFailure] if an exception occurs.
  Future<void> signInWithPhoneNumber({
    required String phoneNumber,
  }) async {
    final verifier = firebase_auth.RecaptchaVerifier(
      auth: FirebaseAuthPlatform.instance,
    );
    try {
      confirmationResult = await _firebaseAuth.signInWithPhoneNumber(
        phoneNumber,
        verifier,
      );
      verifier.clear();
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignInWithPhoneNumberFailure.fromCode(e.code);
    } catch (e) {
      final error = 'SignInWithPhoneNumberFailure: ${e.toString()}';
      throw SignInWithPhoneNumberFailure(error);
    }
  }

  /// Confirm result of authentication with [smsCode].
  ///
  /// Throws a [ConfirmResultFailure] if an exception occurs.
  Future<void> confirmPhoneAuth({required String smsCode}) async {
    try {
      await confirmationResult.confirm(smsCode);
    } on firebase_auth.FirebaseAuthException catch (e) {
      log('firebase_error');
      throw ConfirmResultFailure.fromCode(e.code);
    } catch (e) {
      log('other error');
      throw ConfirmResultFailure(e.toString());
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
