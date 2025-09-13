import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:products_project/features/products/data/models/cart_model/cart_item.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/local data/shared_pref.dart';
import '../../data/models/products_model/product.dart';
import '../../data/models/products_model/products_model.dart';
import '../../data/repos/products_repo.dart';
import '../../data/services/cart_service.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._productsRepo) : super(ProductInitial()) {
    loadCartFromStorage();
  }

  final ProductsRepo _productsRepo;

  ProductsModel? productsModel;

  List<CartItem> cartItems = [];
  List<Product> filteredProducts =[];
  List<String>? neededItemCount = [];
  List<String> categoryList = [];

  String filterData = "";
  String sortingType ='Desc';


  Future<void> fetchProductsData() async {
    emit(GetProductsLoading());
    Either<Failure, ProductsModel> result =
        await _productsRepo.getAllProducts();
    result.fold(
      (failure) {
        log(failure.errMessage);
        emit(GetProductsFailure(errMessage: failure.errMessage));
      },
      (books) {
        productsModel = books;
        filteredProducts = productsModel!.products!;
        emit(GetProductsSuccess());
      },
    );
    neededItemCount = SharedPrefHelper.getStringListValue("cart");
    print(neededItemCount);
    if (neededItemCount == null) {
      neededItemCount = List.generate(productsModel!.products!.length, (index) {
        return "0";
      });
      await SharedPrefHelper.setStingList("cart", neededItemCount!);
    }
  }

  Future<void> fetchCategories() async {
    emit(GetCategoriesLoading());
    Either<Failure, List<String>> result =
        await _productsRepo.getCategoryList();
    result.fold(
      (failure) {
        log(failure.errMessage);
        emit(GetCategoriesFailure(errMessage: failure.errMessage));
      },
      (categories) {
        categoryList = categories;

        categoryList.insert(0,'default');
        filterData = categoryList[0];
        emit(GetCategoriesSuccess());
      },
    );
  }

  logout() async {

  await FirebaseAuth.instance.signOut();

  }

  void changeItemCount(int id, String type) {
    if (type == 'sub') {
      if (neededItemCount![id - 1] != "0") {
        neededItemCount![id - 1] =
            (int.parse(neededItemCount![id - 1]) - 1).toString();
      }
    } else if (type == 'add') {
      neededItemCount![id - 1] =
          (int.parse(neededItemCount![id - 1]) + 1).toString();
    }
    emit(ChangeCartItemCount());
  }

  void readSavedNeededItems() {
    neededItemCount = SharedPrefHelper.getStringListValue("cart");
    print(neededItemCount);
  }

  Future<void> addToCart(Product product, {int quantity = 1}) async {
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      // Product already in cart, update quantity
      final existingItem = cartItems[existingIndex];
      cartItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
      emit(AddCartItem());
    } else {
      // New product, add to cart
      cartItems.add(CartItem(product: product, quantity: quantity));
      emit(AddCartItem());
    }
    await CartService.saveCart(cartItems);
  }

  Future<void> loadCartFromStorage() async {
    cartItems = await CartService.loadCart();
  }

  Future<void> updateQuantity(Product product, int newQuantity) async {
    if (newQuantity <= 0) {
      removeFromCart(product);
      emit(RemoveCartItem());
      return;
    }

    final existingIndex = cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      cartItems[existingIndex] = cartItems[existingIndex].copyWith(
        quantity: newQuantity,
      );

      await CartService.saveCart(cartItems);
      emit(ChangeCartItemCount());
    }
  }

  Future<void> removeFromCart(Product product) async {
    cartItems.removeWhere((item) => item.product.id == product.id);
    await CartService.saveCart(cartItems);
    emit(RemoveCartItem());
  }

  // Clear entire cart
  Future<void> clearCart() async {
    cartItems.clear();
    await CartService.clearCart();
  }

  bool isInCart(Product product) {
    return cartItems.any((item) => item.product.id == product.id);
  }

  int getProductQuantity(Product product) {
    final cartItem = cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => const CartItem(product: Product(), quantity: 0),
    );
    return cartItem.quantity;
  }

  // Get cart item for a product
  CartItem? getCartItem(Product product) {
    try {
      return cartItems.firstWhere((item) => item.product.id == product.id);
    } catch (e) {
      return null;
    }
  }

  void filterProducts(String category) {
    
    filterData = category;
    if(category == "default") {
      filteredProducts = productsModel!.products!;
    } else {
      filteredProducts = productsModel!.products!.where((element) {
      return element.category == category;
    }).toList();
    }
    emit(FilterProducts());
  }

  void sortProductsByCategory( ) {
    if(sortingType == "Asc") {
      filteredProducts.sort((a, b) => a.category!.compareTo(b.category!));
      sortingType = "Desc";
    }else if(sortingType == "Desc") {
      filteredProducts.sort((a, b) => b.category!.compareTo(a.category!));
      sortingType = "Asc";
    }

    emit(SortProducts());
  }
}
