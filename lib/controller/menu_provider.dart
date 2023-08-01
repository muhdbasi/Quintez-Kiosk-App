import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quintez_kiosk_app/hive_model/cart_model.dart';
import 'package:quintez_kiosk_app/model/add_order_model.dart';
import 'package:quintez_kiosk_app/model/customer_model.dart';
import 'package:quintez_kiosk_app/model/menus_model.dart';
import 'package:quintez_kiosk_app/model/order_id_model.dart';
import 'package:quintez_kiosk_app/model/orders_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MenuProvider with ChangeNotifier {
  final supaBase = Supabase.instance.client;
  List<MenusModel> menusList = [];
  List<CartItem> cartItems = [];
  List<CustomerModel> customerList = [];
  List<CustomerModel> customerList2 = [];
  List<OrdersModel> ordersList = [];
  int customerId = 0;

  // int customerID = 0;
  int orderId = 0;
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

  Future<bool> checkCustomer(int phoneNumber) async {
    bool customerFound = false;
    try {
      final response = await supaBase.rpc('get_customers', params: {});
      customerList.clear();
      customerList.addAll(
        customerModelFromJson(
          json.encode(response),
        ),
      );

      log(customerList.length.toString());

      // Flag to indicate if customer is found

      for (int i = 0; i < customerList.length; i++) {
        if (customerList[i].phone.toString() == phoneNumber.toString()) {
          log("${customerList[i].phone} =$phoneNumber");
          customerId = customerList[i].id;
          customerFound = true;
          break; // Customer found, no need to check further
        }
      }

      // if (!customerFound) {
      //   // Customer not found, insert a new customer
      //   final res = await supaBase.rpc(
      //     'insert_using_json',
      //     params: {
      //       "input_table_name": "customers.customers",
      //       "row_data": {
      //         "phone": phoneNumber,
      //         "is_active": true,
      //       }
      //     },
      //   );
      //   log(res.toString());
      // }
    } catch (e) {
      log("check customer Error $e");
    }
    notifyListeners();
    return customerFound;
  }

  Future<OrdersIdModel> addToorderList(
    double totalAmount,
    double discoutAmount,
    int phoneNumber,
  ) async {
    late OrdersIdModel res;
    try {
      await checkCustomer(phoneNumber);
      // await findingCustomerId();
      log("${customerId.toString()}------this------>.");

      final response = await supaBase.rpc(
        'insert_using_json',
        params: {
          "input_table_name": "orders.orders",
          "row_data": {
            "order_date": DateTime.now().toString(),
            "total_amount": totalAmount,
            "discount_amount": discoutAmount,
            "coupon_id": 2,
            "offer_id": 4,
            "space_id": 2,
            "space_touch": 3,
            "server_id": 2,
            "store_id": 1,
            "customer_id": customerId,
            "event_tickets": 2,
          },
        },
      );
      final jsonResponse = json.encode(response);
      res = ordersIdModelFromJson(jsonResponse);
      log(response.toString());
    } catch (e) {
      log('Add to order list Error$e');
    }
    notifyListeners();
    return res;
  }

  Future<void> getOrder(
      double totalAmount, double discoutAmount, int phoneNumber) async {
    final res = await addToorderList(totalAmount, discoutAmount, phoneNumber);
    try {
      final response = await supaBase.rpc('get_orders', params: {});
      ordersList.clear();
      ordersList.add(
        ordersModelFromJson(
          json.encode(
            response,
          ),
        ),
      );
      if (res.success!) {
        orderId = ordersList[0].orders.last.id;
      } else {
        return;
      }

      log(orderId.toString());
    } catch (e) {
      log("Get order Error $e");
    }
  }

  Future<AddOrderModel> addToOrdersItem(List<CartItem> products,
      double totalAmount, double discoutAmount, int phoneNumber) async {
    late AddOrderModel addOrderModel;
    await getOrder(totalAmount, discoutAmount, phoneNumber);
    try {
      for (var i = 0; i < products.length; i++) {
        final response = await supaBase.rpc('insert_using_json', params: {
          "input_table_name": "orders.order_items",
          "row_data": {
            "order_id": orderId,
            "product_id": products[i].productId,
            "service_id": 2,
            "quantity": products[i].quantity.toInt(),
            "unit_price": products[i].price,
            // ? 0.00
            // : products[i].productPricing[0].pricing[0].price,
            "unit_tax": 0.00,
            "subtotal": calculateSubtotal(),
            "is_order_kitchen": true,
            "is_order_bar": false,
            "order_item_status": 4,
            "payments": 1,
            // "description": description[i],
            "images_id": products[i].imageId,
          }
        });
        addOrderModel = AddOrderModel.fromJson(response);
        if (addOrderModel.success) {
          removeFromCart(products[i].productId);
          // removeAllCartItems();
        }
        log(response.toString());
      }
    } catch (e) {
      log("Add to order item Error $e");
    }
    notifyListeners();
    return addOrderModel;
  }

  Future<void> addToCustomerList(int phoneNumber) async {
    try {
      // If no matching customer is found, insert a new customer
      var customerResponse = await supaBase.rpc('insert_using_json', params: {
        "input_table_name": "customers.customers",
        "row_data": {
          "user_id": supaBase.auth.currentUser!.id,
          "phone": phoneNumber,
        }
      });
      log(customerResponse.toString());
    } catch (e) {
      log("Error $e<<<<<<<<<<<<<<<<---------->>>>>>>>");
    }
  }
}
