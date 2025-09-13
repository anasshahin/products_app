import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/validations/auth_validation.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../logic/auth_cubit.dart';

class PasswordRegister extends StatelessWidget {
  const PasswordRegister({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit bloc = BlocProvider.of<AuthCubit>(context);
    return  BlocBuilder<AuthCubit, AuthState>(
      buildWhen:
          (previous, current) => current is ShowPasswordState,
      builder: (context, state) {
        return CustomTextFormField(
          controller:
          bloc
              .textFormFieldControllers
              .passwordRegisterController,
          labelText: 'Password',
          hintText: 'Enter your password',
          obscureText: !bloc.isPasswordShown,
          prefixIcon: const Icon(
            Icons.lock,
            color: AppColor.primaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              bloc.isPasswordShown
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: AppColor.greyColor,
            ),
            onPressed: bloc.changeShowingPassword,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value !=
                bloc
                    .textFormFieldControllers
                    .passwordRegisterController
                    .text) {
              return "the two passwords is not the same";
            }
          return  ValidateData.validatePassword(value);

          },
        );
      },
    );
  }
}
