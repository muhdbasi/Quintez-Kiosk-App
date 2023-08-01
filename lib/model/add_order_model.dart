import 'dart:convert';

AddOrderModel addOrderModelFromJson(String str) =>
    AddOrderModel.fromJson(json.decode(str));

String addOrderModelToJson(AddOrderModel data) => json.encode(data.toJson());

class AddOrderModel {
  bool success;
  String message;
  int? id;

  AddOrderModel({
    required this.success,
    required this.message,
    this.id,
  });

  factory AddOrderModel.fromJson(Map<String, dynamic> json) => AddOrderModel(
        success: json["success"],
        message: json["message"],
        id: json["id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "id": id,
      };
}
