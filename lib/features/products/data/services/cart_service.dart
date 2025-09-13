import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../core/local data/shared_pref.dart';
import '../models/cart_model/cart_item.dart';
import '../models/products_model/product.dart';

class CartService {
  static const String _cartKey = 'cart_products';

  // Save cart products to local storage
  static Future<void> saveCart(List<CartItem> cartItems) async {

    final List<String> cartJsonList = cartItems.map((cartItem) {
      return jsonEncode(cartItem.toJson());
    }).toList();
    await SharedPrefHelper.setStingList(_cartKey, cartJsonList);
  }

  // Load cart products from local storage
  static Future<List<CartItem>> loadCart() async {
    final List<String>? cartJsonList = SharedPrefHelper.getStringListValue(_cartKey);
    if (cartJsonList == null) {
      return [];
    }
    return cartJsonList.map((jsonString) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return CartItem.fromJson(jsonMap);
    }).toList();
  }

  // Clear cart from local storage
  static Future<void> clearCart() async {
    await SharedPrefHelper.removeValue(_cartKey);
  }
}