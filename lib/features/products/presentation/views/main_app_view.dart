import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:products_project/core/router/router.dart';
import 'package:products_project/core/utils/styles.dart';
import 'package:products_project/features/products/presentation/views/widgets/category_sort_filter_row.dart';
import 'package:products_project/features/products/presentation/views/widgets/product_card.dart';
import 'package:products_project/features/products/presentation/views/widgets/products_grid_view.dart';
import 'package:products_project/features/products/presentation/views/widgets/row_data_effects.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/service_locator.dart';
import '../logic/product_cubit.dart';

class MainAppView extends StatelessWidget {
  const MainAppView({super.key});

  @override
  Widget build(BuildContext context) {
    ProductCubit bloc = context.read<ProductCubit>();
    bloc.fetchCategories();
    bloc.fetchProductsData();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          foregroundColor: AppColor.whiteColor,
          title: Text(
            "Products",
            style: Styles.textStyle20.copyWith(color: AppColor.whiteColor,fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.cartProductView);
              },
              icon: Icon(Icons.shopping_cart_sharp),
            ),
            if(getIt.get<FirebaseAuth>().currentUser != null)
            PopupMenuButton(
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      onTap: () async {
                        await bloc.logout();
                        Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
                      },
                      child: const Row(
                        children: [Icon(Icons.logout), Text('logout')],
                      ),
                    ),
                  ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              RowDataEffects(),
              ProductsGridView(),
            ],
          ),
        ),
      ),
    );
  }
}
