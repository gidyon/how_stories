// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/cache.dart';

class FirebaseUser extends Equatable {
  const FirebaseUser({
    required this.id,
    this.email,
    this.name,
    this.photo,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = FirebaseUser(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == FirebaseUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != FirebaseUser.empty;

  @override
  List<Object?> get props => [email, id, name, photo];
}

class SignUpWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository()
      : _firebaseAuth = firebase_auth.FirebaseAuth.instance,
        _cache = CacheClient(),
        _googleSignIn = GoogleSignIn.standard();

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final CacheClient _cache;

  bool isWeb = kIsWeb;

  Stream<FirebaseUser> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user =
          firebaseUser == null ? FirebaseUser.empty : firebaseUser.toUser;
      _cache.write<FirebaseUser>(key: userCacheKey, value: user);
      return user;
    });
  }

  static const userCacheKey = '__user_cache_key__';

  /// Returns the current cached user.
  /// Defaults to [FirebaseUser.empty] if there is no cached user.
  FirebaseUser get currentUser {
    return _cache.read<FirebaseUser>(key: userCacheKey) ?? FirebaseUser.empty;
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  FirebaseUser get toUser {
    return FirebaseUser(
        id: uid, email: email, name: displayName, photo: photoURL);
  }
}
