import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:products_project/features/auth/data/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/auth_failure.dart';
import '../../../../core/utils/service_locator.dart';
import '../models/login_user_data.dart';
import '../models/signup_user_data.dart';



class AuthRepoImpl extends AuthRepo {

final _auth =  getIt.get<FirebaseAuth>();
  @override
  Future<AuthResult<User>> createAccount(SignupUserData signupUserData) async {
    try {
      final userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: signupUserData.email,

        password: signupUserData.password,

      );
      return Right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return Left(_handleFirebaseAuthException(e));
    } catch (e) {
      return Left(UnknownAuthFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<AuthResult<User>> loginAccount(LoginUserData loginUserData) async {
    try {
      final userCredential = await _auth
          .signInWithEmailAndPassword(
        email: loginUserData.email,
        password: loginUserData.password,
      );
      return Right(userCredential.user!);

    } on FirebaseAuthException catch (e) {
      log("code : ${e.code}");
      log("message : ${e.message??''}");
      return Left(_handleFirebaseAuthException(e));
    } catch (e) {
      return Left(UnknownAuthFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }

  // Helper method to handle FirebaseAuthException
  AuthFailure _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return WeakPasswordFailure('The password provided is too weak.');
      case 'email-already-in-use':
        return EmailAlreadyInUseFailure('The account already exists for that email.');
      case 'invalid-email':
        return InvalidEmailFailure('The email address is badly formatted.');
      case 'user-disabled':
        return UserDisabledFailure('This user has been disabled.');
      case 'user-not-found':
        return UserNotFoundFailure('No user found for that email.');
      case 'wrong-password':
        return WrongPasswordFailure('Wrong password provided for that user.');
      case 'network-request-failed':
        return NetworkFailure('Network error occurred. Please check your connection.');
      case 'too-many-requests':
        return NetworkFailure('Too many requests. Please try again later.');
      case 'invalid-credential':
        return _handleInvalidCredential(e.message);
      default:
        return UnknownAuthFailure('An unexpected error occurred: ${e.message}');
    }
  }

// Specific handler for invalid-credential with message parsing
  AuthFailure _handleInvalidCredential(String? message) {
    if (message?.contains('password') == true ||
        message?.contains('Password') == true) {
      return WrongPasswordFailure('Incorrect password. Please try again.');
    } else if (message?.contains('email') == true ||
        message?.contains('Email') == true ||
        message?.contains('user') == true) {
      return UserNotFoundFailure('No account found with this email address.');
    } else {
      return InvalidCredentialsFailure('Invalid login credentials. Please check your email and password.');
    }
  }
}