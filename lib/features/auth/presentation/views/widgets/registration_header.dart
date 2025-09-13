import 'package:flutter/material.dart';

import '../../../../../core/router/router.dart';
import '../../../../../core/utils/styles.dart';
class RegistrationHeader extends StatelessWidget {
  const RegistrationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
          },
          icon: Icon(Icons.arrow_back),
        ),
        SizedBox(width: size.width / 40),
        Text(
          "Registration ",
          style: Styles.textStyle30.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    )
    ;
  }
}
