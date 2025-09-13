import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:products_project/core/utils/app_color.dart';
import 'package:products_project/core/widgets/custom_button.dart';
import 'package:products_project/features/products/presentation/views/widgets/cart_list_items.dart';

import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_snack_bars.dart';
import '../logic/product_cubit.dart';


class CartProductsView extends StatelessWidget {
  const CartProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductCubit>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          backgroundColor: AppColor.primaryColor,
          foregroundColor: AppColor.whiteColor,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           CartListItems(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: CustomButton(backgroundColor: AppColor.primaryColor,
                textColor: AppColor.whiteColor, text: "Check out", onPressed: (){
                var user =  getIt.get<FirebaseAuth>();
                  if(user.currentUser == null) {
                    final snackBar=  customSnackBars(title: "warning registration!",message: "you can't buy without registration please login or sign uo",contentType: ContentType.warning,);
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                    log("not login");
                  } else {

                   if( bloc.cartItems.length==0){
                     final  snackBar =  customSnackBars(title: "the Cart is empty",message: "the Cart is empty",contentType: ContentType.warning,);
                     ScaffoldMessenger.of(context)
                       ..hideCurrentSnackBar()
                       ..showSnackBar(snackBar);
                   }else{

                     final  snackBar =  customSnackBars(title: "Successfully Taken!",message: "your order is taken ",contentType: ContentType.success,);
                     ScaffoldMessenger.of(context)
                       ..hideCurrentSnackBar()
                       ..showSnackBar(snackBar);
                   }

                    log("login");
                  }

                }),
          )
          ],
        ),
      ),
    );
  }
}
