import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:products_project/features/auth/data/models/login_user_data.dart';
import 'package:products_project/features/auth/data/models/signup_user_data.dart';
import 'package:products_project/features/auth/data/repos/auth_repo.dart';

import '../../data/models/text_form_field_controllers.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepo) : super(AuthInitial());
  final AuthRepo _authRepo;
  TextFormFieldControllers textFormFieldControllers =
      TextFormFieldControllers();
  late LoginUserData loginUserData;

  late SignupUserData signupUserData;

  bool isPasswordShown = false;

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();


  Future<void> createUserAccount() async {
    emit(RegisterAccountLoading());
    signupUserData = SignupUserData(email: textFormFieldControllers.emailRegisterController.text,
        password: textFormFieldControllers.passwordRegisterController.text);
    final result = await _authRepo.createAccount(signupUserData);
    result.fold(
      (failure) {
        // Handle error
        emit(RegisterAccountFailure(errMessage: failure.message));
      },
      (user) {
        print(user);
        // Handle success
        emit(RegisterAccountSuccess());
      },
    );
  }

  Future<void> loginUser() async {
    emit(LoginAccountLoading());
    loginUserData = LoginUserData(email: textFormFieldControllers.emailController.text,
        password: textFormFieldControllers.passwordController.text);
    final result = await _authRepo.loginAccount(loginUserData);
    result.fold(
      (failure) {
        // Handle error
        emit(LoginAccountFailure(errMessage: failure.message));
      },
      (user) {
        log("user data that login : ");
        print(user);
        // Handle success
        emit(LoginAccountSuccess());
      },
    );
  }
  void changeShowingPassword(){
    isPasswordShown = !isPasswordShown;
    emit(ShowPasswordState());
  }
}
