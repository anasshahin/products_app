import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_project/core/utils/app_color.dart';
import 'package:products_project/core/widgets/custom_button.dart';
import 'package:products_project/features/auth/presentation/views/widgets/email_login.dart';
import 'package:products_project/features/auth/presentation/views/widgets/password_login.dart';
import 'package:products_project/features/auth/presentation/views/widgets/submit_and_create_account_row.dart';

import '../../../../core/router/router.dart';
import '../../../../core/utils/styles.dart';
import '../logic/auth_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit bloc = BlocProvider.of<AuthCubit>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Form(
          key: bloc.loginFormKey,
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
                  Text(
                    "Login",
                    style: Styles.textStyle30.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height / 15),
                  // Email field
                  EmailLogin(),
                  SizedBox(height: size.height / 20),
                  // Password field
                  PasswordLogin(),
                  SizedBox(height: size.height / 20),
                  SubmitAndCreateAccountRow(),
                  SizedBox(height: size.height / 30),
                  Center(
                    child: CustomButton(backgroundColor: AppColor.primaryColor,
                        textColor: AppColor.whiteColor, text: "Insert as guest", onPressed: (){Navigator.of(context).
                        pushNamed(Routes.mainProductScreen);}),
                  ),
                  SizedBox(height: size.height / 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
