import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:products_project/core/utils/app_color.dart';
import 'package:products_project/core/utils/styles.dart';
import 'package:products_project/core/widgets/custom_button.dart';

import '../../../../core/local data/shared_pref.dart';
import '../../../../core/widgets/custom_snack_bars.dart';
import '../../data/models/products_model/product.dart';
import '../logic/product_cubit.dart';

class DetailsProductView extends StatelessWidget {
  const DetailsProductView({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductCubit>();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              bloc.readSavedNeededItems();
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
          foregroundColor: AppColor.whiteColor,
          title: Text(
            '${product.title}',
            style: Styles.textStyle20.copyWith(color: Colors.white),
          ),
          backgroundColor: AppColor.primaryColor,
        ),
        body: Column(
          children: [
            SizedBox(
              height: size.height / 3,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:
                    product.images!.map((e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColor.greyColor),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: e.toString(),

                            placeholder:
                                (context, url) => Center(
                                  child: SpinKitPulse(
                                    color: AppColor.greyColor,
                                    size: 50.0,
                                  ),
                                ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            SizedBox(height: size.height / 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                product.description!,
                maxLines: 10,
                textAlign: TextAlign.start,
                style: Styles.textStyle16,
              ),
            ),
            Spacer(), // pushes the next widget to the bottom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: Row(
                children: [
                  FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: () {
                      bloc.changeItemCount(product.id!, 'add');
                    },
                    backgroundColor: AppColor.primaryColor,
                    child: Icon(Icons.add, color: AppColor.whiteColor),
                  ),
                  SizedBox(width: size.width / 30),
                  BlocBuilder<ProductCubit, ProductState>(
                    buildWhen:
                        (previous, current) => current is ChangeCartItemCount,
                    builder: (context, state) {
                      return Text(
                        bloc.neededItemCount![product.id! - 1],
                        style: Styles.textStyle16.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  SizedBox(width: size.width / 30),
                  FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: () {
                      bloc.changeItemCount(product.id!, 'sub');
                    },
                    backgroundColor: AppColor.primaryColor,
                    child: Icon(Icons.remove, color: AppColor.whiteColor),
                  ),
                  SizedBox(width: size.width / 30),
                  BlocBuilder<ProductCubit, ProductState>(
                    buildWhen:
                        (previous, current) => current is ChangeCartItemCount,
                    builder: (context, state) {
                      double totalPrice =
                          product.price! *
                          int.parse(bloc.neededItemCount![product.id! - 1]);
                      return Text(
                        totalPrice.toStringAsFixed(2),
                        style: Styles.textStyle20.copyWith(
                          color: AppColor.greenColor,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),

                  Spacer(),
                  BlocListener<ProductCubit, ProductState>(
                    listenWhen: (previous, current) => current is AddCartItem,
                    listener: (context, state) {
                      final snackBar=  customSnackBars(title: 'Success',message:  "Add ${product.title} to cart",contentType: ContentType.success,);
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    },
                    child: CustomButton(
                      backgroundColor: AppColor.primaryColor,
                      textColor: AppColor.whiteColor,
                      text: "add to Cart",
                      onPressed: () {
                        if(bloc.neededItemCount![product.id! - 1] == "0") {
                          final snackBar=  customSnackBars(title: 'Warning added ${product.title}',message: "you  can't add 0 of ${product.title}",contentType: ContentType.warning,);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        }
                       else{
                          bloc.addToCart(
                            product,
                            quantity: int.parse(
                              bloc.neededItemCount![product.id! - 1],
                            ),
                          );
                          SharedPrefHelper.setStingList(
                            "cart",
                            bloc.neededItemCount!,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
