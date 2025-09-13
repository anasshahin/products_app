import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/router/router.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/service_locator.dart';

class StartingAppView extends StatefulWidget {
  const StartingAppView({super.key});

  @override
  State<StartingAppView> createState() => _StartingAppViewState();
}

class _StartingAppViewState extends State<StartingAppView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      final user = getIt.get<FirebaseAuth>();
      if(user.currentUser == null){
        Navigator.pushReplacementNamed(context, Routes.loginScreen);
      }else{
        Navigator.pushReplacementNamed(context, Routes.mainProductScreen);
      }

    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(child: SpinKitSpinningLines(
        color: AppColor.darkPrimaryColor,
        size: 50.0,

      ),),
    );
  }
}
