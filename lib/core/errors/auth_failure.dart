import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

// Error types
// Error types
abstract class AuthFailure {
  final String message;
  AuthFailure(this.message);
}

class NetworkFailure extends AuthFailure {
  NetworkFailure(super.message);
}

class InvalidCredentialsFailure extends AuthFailure {
  InvalidCredentialsFailure(super.message);
}

class InvalidEmailFailure extends AuthFailure {
  InvalidEmailFailure(super.message);
}

class WrongPasswordFailure extends AuthFailure {
  WrongPasswordFailure(super.message);
}

class UserNotFoundFailure extends AuthFailure {
  UserNotFoundFailure(super.message);
}

class UserDisabledFailure extends AuthFailure {
  UserDisabledFailure(super.message);
}

class EmailAlreadyInUseFailure extends AuthFailure {
  EmailAlreadyInUseFailure(super.message);
}

class WeakPasswordFailure extends AuthFailure {
  WeakPasswordFailure(super.message);
}

class PlatformSetupFailure extends AuthFailure {
  final PlatformException? platformException;

  PlatformSetupFailure(super.message, [this.platformException]);
}

class UnknownAuthFailure extends AuthFailure {
  UnknownAuthFailure(super.message);
}
// Either type alias for cleaner code
typedef AuthResult<T> = Either<AuthFailure, T>;