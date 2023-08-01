import 'dart:convert';

OrdersModel ordersModelFromJson(String str) =>
    OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  List<Role> roles;
  List<Order> orders;
  List<Profile> profiles;

  OrdersModel({
    required this.roles,
    required this.orders,
    required this.profiles,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
        profiles: List<Profile>.from(
            json["profiles"].map((x) => Profile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
        "profiles": List<dynamic>.from(profiles.map((x) => x.toJson())),
      };
}

class Order {
  int id;
  int offerId;
  int spaceId;
  int storeId;
  int couponId;
  int serverId;
  DateTime orderDate;
  int customerId;
  int spaceTouch;
  double totalAmount;
  int eventTickets;
  double discountAmount;

  Order({
    required this.id,
    required this.offerId,
    required this.spaceId,
    required this.storeId,
    required this.couponId,
    required this.serverId,
    required this.orderDate,
    required this.customerId,
    required this.spaceTouch,
    required this.totalAmount,
    required this.eventTickets,
    required this.discountAmount,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        offerId: json["offer_id"],
        spaceId: json["space_id"],
        storeId: json["store_id"],
        couponId: json["coupon_id"],
        serverId: json["server_id"],
        orderDate: DateTime.parse(json["order_date"]),
        customerId: json["customer_id"],
        spaceTouch: json["space_touch"],
        totalAmount: json["total_amount"]?.toDouble(),
        eventTickets: json["event_tickets"],
        discountAmount: json["discount_amount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "offer_id": offerId,
        "space_id": spaceId,
        "store_id": storeId,
        "coupon_id": couponId,
        "server_id": serverId,
        "order_date": orderDate.toIso8601String(),
        "customer_id": customerId,
        "space_touch": spaceTouch,
        "total_amount": totalAmount,
        "event_tickets": eventTickets,
        "discount_amount": discountAmount,
      };
}

class Profile {
  String id;
  int? roleId;
  String? website;
  String? username;
  String? fullName;
  String? avatarUrl;
  DateTime createdAt;
  DateTime updatedAt;
  int? languageId;

  Profile({
    required this.id,
    this.roleId,
    this.website,
    this.username,
    this.fullName,
    this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
    this.languageId,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        roleId: json["role_id"],
        website: json["website"],
        username: json["username"],
        fullName: json["full_name"],
        avatarUrl: json["avatar_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        languageId: json["language_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "website": website,
        "username": username,
        "full_name": fullName,
        "avatar_url": avatarUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "language_id": languageId,
      };
}

class Role {
  int id;
  String name;
  DateTime createdAt;
  String description;

  Role({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.description,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "description": description,
      };
}
