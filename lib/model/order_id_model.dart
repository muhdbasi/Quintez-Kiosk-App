import 'dart:convert';

OrdersIdModel ordersIdModelFromJson(String str) =>
    OrdersIdModel.fromJson(json.decode(str));

String ordersIdModelToJson(OrdersIdModel data) => json.encode(data.toJson());

class OrdersIdModel {
  bool? success;
  String? message;
  int? id;

  OrdersIdModel({
    this.success,
    this.message,
    this.id,
  });

  factory OrdersIdModel.fromJson(Map<String, dynamic> json) => OrdersIdModel(
        success: json["success"] ?? false, // Default value is false if null
        message:
            json["message"] ?? '', // Default value is an empty string if null
        id: json["id"] ?? 0, // Default value is 0 if null
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "id": id,
      };
}
