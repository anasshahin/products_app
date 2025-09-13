import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/validations/auth_validation.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../logic/auth_cubit.dart';

class EmailLogin extends StatelessWidget {
  const EmailLogin({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit bloc = BlocProvider.of<AuthCubit>(context);
    return  CustomTextFormField(
      controller: bloc.textFormFieldControllers.emailController,
      labelText: 'Email Address',
      hintText: 'Enter your email',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(
        Icons.email,
        color: AppColor.primaryColor,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        ValidateData.validateEmail(value);
        return null;
      },
    );
  }
}
