import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../core/utils/app_color.dart';
import '../../logic/product_cubit.dart';
import 'category_sort_filter_row.dart';

class RowDataEffects extends StatelessWidget {
  const RowDataEffects({super.key});

  @override
  Widget build(BuildContext context) {
    ProductCubit bloc = context.read<ProductCubit>();
    return   BlocBuilder<ProductCubit, ProductState>(
      buildWhen:
          (previous, current) =>
      current is GetCategoriesLoading ||
          current is GetCategoriesSuccess ||
          current is GetCategoriesFailure,
      builder: (context, state) {
        if (state is GetCategoriesLoading) {
          return Center(
            child: SpinKitPulse(
              color: AppColor.greyColor,
              size: 50.0,
            ),
          );
        }
        if (state is GetCategoriesFailure) return Text(state.errMessage);

        return CategorySortRow(
          categories: bloc.categoryList,
          onSortChanged: (category, isAscending) {

          },
        );
      },
    );
  }
}
