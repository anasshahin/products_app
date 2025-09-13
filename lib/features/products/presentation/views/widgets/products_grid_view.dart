import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:products_project/features/products/presentation/views/widgets/product_card.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/widgets/custom_snack_bars.dart';
import '../../logic/product_cubit.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    ProductCubit bloc = context.read<ProductCubit>();
    return BlocConsumer<ProductCubit, ProductState>(
      listenWhen:
          (previous, current) => current is GetProductsFailure,
      buildWhen:
          (previous, current) =>
      current is GetProductsLoading ||
          current is FilterProducts ||
          current is SortProducts ||
          current is GetProductsSuccess,
      listener: (context, state) {
        if (state is GetProductsFailure) {
          final snackBar=  customSnackBars(title: 'Error happen!',message: state.errMessage,contentType: ContentType.failure,);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        if (state is GetProductsLoading) {
          return Center(
            child: SpinKitCubeGrid(
              color: AppColor.darkPrimaryColor,
              size: 50.0,
            ),
          );
        }
        if (state is GetProductsSuccess ||
            state is FilterProducts ||
            state is SortProducts ) {
          return Expanded(
            child: GridView.builder(
              itemCount: bloc.filteredProducts.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // two items per row
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7, // adjust height ratio
              ),
              itemBuilder: (context, index) {
                final product = bloc.filteredProducts[index];
                return ProductCard(product: product);
              },
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
