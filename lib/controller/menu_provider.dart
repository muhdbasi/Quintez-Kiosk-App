import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quintez_kiosk_app/hive_model/cart_model.dart';
import 'package:quintez_kiosk_app/model/menus_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MenuProvider with ChangeNotifier {
  final supaBase = Supabase.instance.client;
  List<MenusModel> menusList = [];
  List<CartItem> cartItems = [];
  Future<void> getMenus() async {
    try {
      var response = await supaBase.rpc('get_menus_v4', params: {
        "st_id": 1,
      });
      menusList.clear();
      menusList.add(
        menusModelFromJson(
          json.encode(
            response,
          ),
        ),
      );
      log(menusList[0].menus.length.toString());
    } catch (e) {
      log("Error $e");
    }
    notifyListeners();
  }

  void onMenuOptionSelected(
      String option, ValueNotifier selectedOptionNotifier) {
    selectedOptionNotifier.value = option;
    notifyListeners();
  }

  void addToCart(CartItem item) {
    // Check if the item already exists in the cart
    final existingItemIndex = cartItems.indexWhere(
      (element) => element.productId == item.productId,
    );

    if (existingItemIndex != -1) {
      // If the item already exists, update the quantity
      cartItems[existingItemIndex].quantity += item.quantity;
    } else {
      // If the item doesn't exist, add it to the cart
      cartItems.add(item);
    }

    notifyListeners();
    log(cartItems[0].productName);
  }

  void updateCartItemQuantity(int productId, int quantity) {
    final cartItemIndex = cartItems.indexWhere(
      (element) => element.productId == productId,
    );

    if (cartItemIndex != -1) {
      cartItems[cartItemIndex].quantity = quantity;
      notifyListeners();
    }
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }

  bool isProductInCart(int productId) {
    return cartItems.any((item) => item.productId == productId);
  }

  void removeFromCart(int productId) {
    final cartItemIndex = cartItems.indexWhere(
      (element) => element.productId == productId,
    );

    if (cartItemIndex != -1) {
      cartItems.removeAt(cartItemIndex);
      notifyListeners();
    }
  }

  // <<>>>
}
