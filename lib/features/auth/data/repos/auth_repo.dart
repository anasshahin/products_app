import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/auth_failure.dart';
import '../models/login_user_data.dart';
import '../models/signup_user_data.dart';

abstract class AuthRepo {
  Future<AuthResult<User>> createAccount(SignupUserData signupUserData);
  Future<AuthResult<User>> loginAccount(LoginUserData loginUserData);

}
