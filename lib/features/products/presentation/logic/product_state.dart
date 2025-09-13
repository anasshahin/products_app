part of 'product_cubit.dart';

@immutable
sealed class ProductState  {

}

final class ProductInitial extends ProductState {}
final class GetProductsLoading extends ProductState {}
final class GetProductsSuccess extends ProductState {}
final class GetProductsFailure extends ProductState {
  final String errMessage;
   GetProductsFailure({required this.errMessage});
}

final class GetCategoriesLoading extends ProductState {}
final class GetCategoriesSuccess extends ProductState {}
final class GetCategoriesFailure extends ProductState {
  final String errMessage;
  GetCategoriesFailure({required this.errMessage});
}

final class ChangeCartItemCount extends ProductState {}
final class RemoveCartItem extends ProductState {}
final class AddCartItem extends ProductState {}
final class FilterProducts extends ProductState {}

final class SortProducts extends ProductState {}
