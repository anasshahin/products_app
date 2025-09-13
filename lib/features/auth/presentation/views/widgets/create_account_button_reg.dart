import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/router/router.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_snack_bars.dart';
import '../../logic/auth_cubit.dart';

class CreateAccountButtonReg extends StatelessWidget {
  const CreateAccountButtonReg({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit bloc = BlocProvider.of<AuthCubit>(context);
    return  Center(
      child: BlocConsumer<AuthCubit, AuthState>(
        listenWhen:
            (previous, current) =>
        current is RegisterAccountFailure ||
            current is RegisterAccountSuccess,
        listener: (context, state) {
          if (state is RegisterAccountFailure) {
            final snackBar=  customSnackBars(title: "Error happen!",message: state.errMessage,contentType: ContentType.failure,);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          }
          if (state is RegisterAccountSuccess) {
            log('successfully done');
            Navigator.of(context).pop();
            Navigator.of(
              context,
            ).pushReplacementNamed(Routes.mainProductScreen);
          }
        },
        builder: (context, state) {
          if (state is RegisterAccountLoading) {
            return CircularProgressIndicator();
          }
          return CustomButton(
            onPressed: () {
              if (bloc.signupFormKey.currentState!.validate()) {
                bloc.createUserAccount();
              }
            },
            text: "Create account",
            backgroundColor: AppColor.primaryColor,
            textColor: AppColor.whiteColor,
          );
        },
      ),
    );
  }
}
