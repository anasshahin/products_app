import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_project/features/auth/presentation/views/widgets/create_account_button_reg.dart';
import 'package:products_project/features/auth/presentation/views/widgets/email_register.dart';
import 'package:products_project/features/auth/presentation/views/widgets/password_register.dart';
import 'package:products_project/features/auth/presentation/views/widgets/re_password_register.dart';
import 'package:products_project/features/auth/presentation/views/widgets/registration_header.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/validations/auth_validation.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../logic/auth_cubit.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit bloc = BlocProvider.of<AuthCubit>(context);
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(

      body: Center(
        child: Form(
          key: bloc.signupFormKey,
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: size.height / 30),
                  RegistrationHeader(),
                  SizedBox(height: size.height / 15),
                  EmailRegister(),
                  SizedBox(height: size.height / 20),
                  // Password field
                  PasswordRegister(),
                  SizedBox(height: size.height / 20),
                  RePasswordRegister(),
                  SizedBox(height: size.height / 20),
                  CreateAccountButtonReg(),
                  SizedBox(height: size.height / 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
