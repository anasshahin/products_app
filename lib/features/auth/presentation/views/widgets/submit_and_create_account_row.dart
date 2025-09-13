import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/router/router.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_snack_bars.dart';
import '../../logic/auth_cubit.dart';
class SubmitAndCreateAccountRow extends StatelessWidget {
  const SubmitAndCreateAccountRow({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit bloc = BlocProvider.of<AuthCubit>(context);
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if(state is LoginAccountFailure) {
              final snackBar=  customSnackBars(title: "Error happen!",message: state.errMessage,contentType: ContentType.failure,);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            }
            if(state is LoginAccountSuccess) {
              Navigator.of(context).pushReplacementNamed(Routes.mainProductScreen);
            }
          },
          builder: (context, state) {
            if(state is LoginAccountLoading) {
              return CircularProgressIndicator();
            }
            return Expanded(
              flex: 1,
              child: CustomButton(
                        text: 'Submit',
                        backgroundColor: AppColor.primaryColor,textColor: AppColor.whiteColor,
                        onPressed: (){
              if (bloc.loginFormKey.currentState!.validate()) bloc.loginUser();
                        },),
            );
          },
        ),
        Expanded(
          flex: 1,
          child: CustomButton(
            text: 'Create account',
            textColor:AppColor.primaryColor,backgroundColor: AppColor.transparentColor,
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(Routes.registrationScreen);
            },),
        )
      ],
    );
  }
}
