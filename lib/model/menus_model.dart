// To parse this JSON data, do
//
//     final menusModel = menusModelFromJson(jsonString);

import 'dart:convert';

MenusModel menusModelFromJson(String str) =>
    MenusModel.fromJson(json.decode(str));

String menusModelToJson(MenusModel data) => json.encode(data.toJson());

class MenusModel {
  List<MenuElement> menus;

  MenusModel({
    required this.menus,
  });

  factory MenusModel.fromJson(Map<String, dynamic> json) => MenusModel(
        menus: List<MenuElement>.from(
            json["menus"].map((x) => MenuElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "menus": List<dynamic>.from(menus.map((x) => x.toJson())),
      };
}

class MenuElement {
  MenuMenu menu;
  List<ProductElement>? products;

  MenuElement({
    required this.menu,
    this.products,
  });

  factory MenuElement.fromJson(Map<String, dynamic> json) => MenuElement(
        menu: MenuMenu.fromJson(json["menu"]),
        products: json["products"] == null
            ? []
            : List<ProductElement>.from(
                json["products"]!.map((x) => ProductElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "menu": menu.toJson(),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class MenuMenu {
  int menuId;
  int storeId;
  String menuName;
  String menuType;
  DateTime createdAt;
  DateTime updatedAt;
  String availableTo;
  List<String> availableDays;
  String availableFrom;
  String menuDescription;

  MenuMenu({
    required this.menuId,
    required this.storeId,
    required this.menuName,
    required this.menuType,
    required this.createdAt,
    required this.updatedAt,
    required this.availableTo,
    required this.availableDays,
    required this.availableFrom,
    required this.menuDescription,
  });

  factory MenuMenu.fromJson(Map<String, dynamic> json) => MenuMenu(
        menuId: json["menu_id"],
        storeId: json["store_id"],
        menuName: json["menu_name"],
        menuType: json["menu_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        availableTo: json["available_to"],
        availableDays: List<String>.from(json["available_days"].map((x) => x)),
        availableFrom: json["available_from"],
        menuDescription: json["menu_description"],
      );

  Map<String, dynamic> toJson() => {
        "menu_id": menuId,
        "store_id": storeId,
        "menu_name": menuName,
        "menu_type": menuType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "available_to": availableTo,
        "available_days": List<dynamic>.from(availableDays.map((x) => x)),
        "available_from": availableFrom,
        "menu_description": menuDescription,
      };
}

class ProductElement {
  ProductProduct product;
  List<Pricing> pricings;

  ProductElement({
    required this.product,
    required this.pricings,
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        product: ProductProduct.fromJson(json["product"]),
        pricings: List<Pricing>.from(
            json["pricings"].map((x) => Pricing.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "pricings": List<dynamic>.from(pricings.map((x) => x.toJson())),
      };
}

class Pricing {
  double price;
  int priceId;
  int productPricingId;

  Pricing({
    required this.price,
    required this.priceId,
    required this.productPricingId,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
        price: json["price"]?.toDouble(),
        priceId: json["price_id"],
        productPricingId: json["product_pricing_id"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "price_id": priceId,
        "product_pricing_id": productPricingId,
      };
}

class ProductProduct {
  String sku;
  String name;
  List<Image> images;
  bool isSale;
  int brandId;
  bool isActive;
  int productId;
  int categoryId;
  String description;
  bool isInventory;
  String categoryName;
  int caterTypeId;
  CaterTypeName caterTypeName;
  String unitOfMeasure;

  ProductProduct({
    required this.sku,
    required this.name,
    required this.images,
    required this.isSale,
    required this.brandId,
    required this.isActive,
    required this.productId,
    required this.categoryId,
    required this.description,
    required this.isInventory,
    required this.categoryName,
    required this.caterTypeId,
    required this.caterTypeName,
    required this.unitOfMeasure,
  });

  factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
        sku: json["sku"],
        name: json["name"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        isSale: json["is_sale"],
        brandId: json["brand_id"],
        isActive: json["is_active"],
        productId: json["product_id"],
        categoryId: json["category_id"],
        description: json["description"],
        isInventory: json["is_inventory"],
        categoryName: json["category_name"],
        caterTypeId: json["cater_type_id"],
        caterTypeName: caterTypeNameValues.map[json["cater_type_name"]]!,
        unitOfMeasure: json["unit_of_measure"],
      );

  Map<String, dynamic> toJson() => {
        "sku": sku,
        "name": name,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "is_sale": isSale,
        "brand_id": brandId,
        "is_active": isActive,
        "product_id": productId,
        "category_id": categoryId,
        "description": description,
        "is_inventory": isInventory,
        "category_name": categoryName,
        "cater_type_id": caterTypeId,
        "cater_type_name": caterTypeNameValues.reverse[caterTypeName],
        "unit_of_measure": unitOfMeasure,
      };
}

enum CaterTypeName { BAR, KITCHEN, READY_TO_SERVE }

final caterTypeNameValues = EnumValues({
  "bar": CaterTypeName.BAR,
  "kitchen": CaterTypeName.KITCHEN,
  "ready to serve": CaterTypeName.READY_TO_SERVE
});

class Image {
  int id;
  String imageUrl;
  String thumbnailUrl;

  Image({
    required this.id,
    required this.imageUrl,
    required this.thumbnailUrl,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        imageUrl: json["image_url"],
        thumbnailUrl: json["thumbnail_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "thumbnail_url": thumbnailUrl,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
