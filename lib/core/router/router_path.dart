import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_project/core/router/router.dart';
import 'package:products_project/features/auth/data/repos/auth_repo_impl.dart';
import 'package:products_project/features/auth/presentation/logic/auth_cubit.dart';
import 'package:products_project/features/products/presentation/logic/product_cubit.dart';

import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/registration_view.dart';
import '../../features/products/data/models/products_model/product.dart';
import '../../features/products/data/repos/products_repo_impl.dart';
import '../../features/products/presentation/views/cart_products_view.dart';
import '../../features/products/presentation/views/details_product_view.dart';
import '../../features/products/presentation/views/main_app_view.dart';
import '../utils/service_locator.dart';

class AppRouter {
  AuthCubit authCubit = AuthCubit(getIt.get<AuthRepoImpl>());
  ProductCubit productCubit = ProductCubit(getIt.get<ProductsRepoImpl>());

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.loginScreen:
        return navigateToRoute(
            BlocProvider.value(
              value: authCubit,
              child: LoginView(),
            )
        );

      case Routes.registrationScreen:
        return navigateToRoute(
            BlocProvider.value(
              value: authCubit,
              child: RegistrationView(),
            )
        );
      case Routes.detailsProductView:
        Product product =settings.arguments as Product;
        return navigateToRoute(

            BlocProvider.value(
              value: productCubit,
              child: DetailsProductView(product: product,),
            )
        );
      case Routes.mainProductScreen:
        return navigateToRoute(
            BlocProvider.value(
              value: productCubit,
              child: MainAppView()
            )
        );

      case Routes.cartProductView:
        return navigateToRoute(
            BlocProvider.value(
                value: productCubit,
                child: CartProductsView()
            )
        );


      default:
        return navigateToRoute(
          Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  void dispose() {

  }

  navigateToRoute(Widget page) {
    if (Platform.isAndroid) {
      return MaterialPageRoute(builder: (_) => page);
    }

    if (Platform.isIOS) {
      return CupertinoPageRoute(builder: (_) => page);
    }
  }
}
