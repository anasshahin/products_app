part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}


final class RegisterAccountLoading extends AuthState {}
final class RegisterAccountSuccess extends AuthState {}
final class RegisterAccountFailure extends AuthState {
  final String errMessage;
   RegisterAccountFailure({required this.errMessage});
}

final class LoginAccountLoading extends AuthState {}
final class LoginAccountSuccess extends AuthState {}
final class LoginAccountFailure extends AuthState {
  final String errMessage;

  LoginAccountFailure({required this.errMessage});
}
final class ShowPasswordState extends AuthState {}