import 'dart:convert';

List<CustomerModel> customerModelFromJson(String str) =>
    List<CustomerModel>.from(
        json.decode(str).map((x) => CustomerModel.fromJson(x)));

String customerModelToJson(List<CustomerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerModel {
  int id;
  String userId;
  String? firstName;
  String? lastName;
  String? email;
  int? phone;
  Address? address;
  DateTime? dateOfBirth;
  DateTime createdAt;
  DateTime updatedAt;
  bool? isActive;

  CustomerModel({
    required this.id,
    required this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.address,
    this.dateOfBirth,
    required this.createdAt,
    required this.updatedAt,
    this.isActive,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: json["id"],
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "address": address?.toJson(),
        "date_of_birth": dateOfBirth?.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_active": isActive,
      };
}

class Address {
  String? city;
  String? state;
  String? street;
  String? zipcode;

  Address({
    this.city,
    this.state,
    this.street,
    this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"],
        state: json["state"],
        street: json["street"],
        zipcode: json["zipcode"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "state": state,
        "street": street,
        "zipcode": zipcode,
      };
}
