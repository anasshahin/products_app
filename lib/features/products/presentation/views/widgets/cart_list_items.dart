import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_color.dart';
import '../../logic/product_cubit.dart';
class CartListItems extends StatelessWidget {
  const CartListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductCubit>();
    return  BlocBuilder<ProductCubit, ProductState>(
      buildWhen:
          (previous, current) =>
      current is RemoveCartItem || current is AddCartItem,
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
            itemCount: bloc.cartItems.length,

            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.blackColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(bloc.cartItems[index].product.title!),

                  subtitle: Row(
                    children: [
                      BlocBuilder<ProductCubit, ProductState>(
                        buildWhen:
                            (previous, current) =>
                        current is ChangeCartItemCount,
                        builder: (context, state) {
                          return Text(
                            "price : ${(bloc.cartItems[index].product.price! * bloc.cartItems[index].quantity).toInt()}  ",
                          );
                        },
                      ),
                      BlocBuilder<ProductCubit, ProductState>(
                        buildWhen:
                            (previous, current) =>
                        current is ChangeCartItemCount,
                        builder: (context, state) {
                          return Text(
                            "quantity : ${bloc.cartItems[index].quantity}",
                          );
                        },
                      ),

                      GestureDetector(
                        onTap: () async {
                          await bloc.updateQuantity(
                            bloc.cartItems[index].product,
                            bloc.cartItems[index].quantity + 1,
                          );
                        },
                        child: Icon(Icons.add),
                      ),
                      IconButton(
                        onPressed: () async {
                          await bloc.updateQuantity(
                            bloc.cartItems[index].product,
                            bloc.cartItems[index].quantity - 1,
                          );
                        },
                        icon: Icon(Icons.remove),
                      ),
                      GestureDetector(
                        onTap: () {
                          bloc.removeFromCart(bloc.cartItems[index].product);
                        },
                        child: Icon(Icons.delete),
                      ),
                    ],
                  ),
                  leading: CircleAvatar(
                    child: CachedNetworkImage(
                      imageUrl: bloc.cartItems[index].product.thumbnail!,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
