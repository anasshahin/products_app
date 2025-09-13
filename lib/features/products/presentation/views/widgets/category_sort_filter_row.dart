import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/product_cubit.dart';

class CategorySortRow extends StatefulWidget {
  final List<String> categories;
  final void Function(String category, bool isAscending) onSortChanged;

  const CategorySortRow({
    super.key,
    required this.categories,
    required this.onSortChanged,
  });

  @override
  State<CategorySortRow> createState() => _CategorySortRowState();
}

class _CategorySortRowState extends State<CategorySortRow> {
  bool isAscending = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductCubit>();
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          // Dropdown for categories
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: BlocBuilder<ProductCubit, ProductState>(
                  buildWhen: (previous, current) => current is FilterProducts,
                  builder: (context, state) {
                    return DropdownButton<String>(
                      value: bloc.filterData,
                      isExpanded: true,
                      items: widget.categories
                          .map((category) =>
                          DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          ))
                          .toList(),
                      onChanged: (value) {
                        bloc.filterProducts(value ?? "");
                      },
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Sort button
          BlocBuilder<ProductCubit, ProductState>(
            buildWhen: (previous, current) => current is SortProducts,
            builder: (context, state) {
              return ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => bloc.sortProductsByCategory(),

                icon: Icon(
                    bloc.sortingType == "Asc" ? Icons.arrow_upward : Icons.arrow_downward),
                label: Text(bloc.sortingType),
              );
            },
          ),
        ],
      ),
    );
  }
}
