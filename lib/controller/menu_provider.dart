import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quintez_kiosk_app/hive_model/cart_model.dart';
import 'package:quintez_kiosk_app/model/customer_model.dart';
import 'package:quintez_kiosk_app/model/menus_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MenuProvider with ChangeNotifier {
  final supaBase = Supabase.instance.client;
  List<MenusModel> menusList = [];
  List<CartItem> cartItems = [];
  List<CustomerModel> customerList = [];
  int customerId = 0;
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
      // final jsonData = jsonEncode(response);
      // log(jsonData.toString());
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

  void incrementCartItemQuantity(int productId) {
    final cartItemIndex = cartItems.indexWhere(
      (element) => element.productId == productId,
    );

    if (cartItemIndex != -1) {
      cartItems[cartItemIndex].quantity++;
      notifyListeners();
    }
  }

  void decrementCartItemQuantity(int productId) {
    final cartItemIndex = cartItems.indexWhere(
      (element) => element.productId == productId,
    );

    if (cartItemIndex != -1) {
      if (cartItems[cartItemIndex].quantity > 1) {
        cartItems[cartItemIndex].quantity--;
      } else {
        // Remove the item from the cart if its quantity becomes 0
        cartItems.removeAt(cartItemIndex);
      }
      notifyListeners();
    }
  }

  double calculateTotalAmount(int quantity, double price) {
    double totalAmount = quantity * price;
    return totalAmount;
  }

  double calculateSubtotal() {
    double subtotal = 0.0;
    for (CartItem cartItem in cartItems) {
      double productPrice = cartItem.price;
      int quantity = cartItem.quantity;
      subtotal += (productPrice * quantity);
    }
    return subtotal;
  }

  Future<void> checkCustomer(int phoneNumber) async {
    try {
      final response = await supaBase.rpc('get_customers', params: {});
      // final jsonData = jsonEncode(response);
      // log(jsonData.toString());

      customerList.clear();
      customerList.addAll(
        customerModelFromJson(
          json.encode(response),
        ),
      );

      log(customerList[0].phone.toString());
      for (int i = 0; i < customerList.length; i++) {
        if (customerList[i].phone.toString() == phoneNumber.toString()) {
          log("${customerList[i].phone} =$phoneNumber");
          customerId = customerList[i].id;
        } else {
          final res = await supaBase.rpc(
            'insert_using_json',
            params: {
              "input_table_name": "customers.customers",
              "row_data": {
                "phone": phoneNumber,
                "is_active": true,
              }
            },
          );
          log(res.toString());
          return;
        }
      }
    } catch (e) {
      log("Error $e");
    }
    notifyListeners();
  }
}
