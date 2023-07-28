import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:quintez_kiosk_app/model/menus_model.dart';

class MenusModelAdapter extends TypeAdapter<MenusModel> {
  @override
  int get typeId => 0; // You can set a unique typeId for each type adapter.

  @override
  MenusModel read(BinaryReader reader) {
    final Map<String, dynamic> jsonData = json.decode(reader.read());
    return MenusModel.fromJson(jsonData);
  }

  @override
  void write(BinaryWriter writer, MenusModel obj) {
    final jsonString = json.encode(obj.toJson());
    writer.write(jsonString);
  }
}

class MenuElementAdapter extends TypeAdapter<MenuElement> {
  @override
  int get typeId => 1; // You can set a unique typeId for each type adapter.

  @override
  MenuElement read(BinaryReader reader) {
    final Map<String, dynamic> jsonData = json.decode(reader.read());
    return MenuElement.fromJson(jsonData);
  }

  @override
  void write(BinaryWriter writer, MenuElement obj) {
    final jsonString = json.encode(obj.toJson());
    writer.write(jsonString);
  }
}

class MenuMenuAdapter extends TypeAdapter<MenuMenu> {
  @override
  int get typeId => 2; // You can set a unique typeId for each type adapter.

  @override
  MenuMenu read(BinaryReader reader) {
    final Map<String, dynamic> jsonData = json.decode(reader.read());
    return MenuMenu.fromJson(jsonData);
  }

  @override
  void write(BinaryWriter writer, MenuMenu obj) {
    final jsonString = json.encode(obj.toJson());
    writer.write(jsonString);
  }
}

class ProductElementAdapter extends TypeAdapter<ProductElement> {
  @override
  int get typeId => 3; // You can set a unique typeId for each type adapter.

  @override
  ProductElement read(BinaryReader reader) {
    final Map<String, dynamic> jsonData = json.decode(reader.read());
    return ProductElement.fromJson(jsonData);
  }

  @override
  void write(BinaryWriter writer, ProductElement obj) {
    final jsonString = json.encode(obj.toJson());
    writer.write(jsonString);
  }
}

class PricingAdapter extends TypeAdapter<Pricing> {
  @override
  int get typeId => 4; // You can set a unique typeId for each type adapter.

  @override
  Pricing read(BinaryReader reader) {
    final Map<String, dynamic> jsonData = json.decode(reader.read());
    return Pricing.fromJson(jsonData);
  }

  @override
  void write(BinaryWriter writer, Pricing obj) {
    final jsonString = json.encode(obj.toJson());
    writer.write(jsonString);
  }
}

class ProductProductAdapter extends TypeAdapter<ProductProduct> {
  @override
  int get typeId => 5; // You can set a unique typeId for each type adapter.

  @override
  ProductProduct read(BinaryReader reader) {
    final Map<String, dynamic> jsonData = json.decode(reader.read());
    return ProductProduct.fromJson(jsonData);
  }

  @override
  void write(BinaryWriter writer, ProductProduct obj) {
    final jsonString = json.encode(obj.toJson());
    writer.write(jsonString);
  }
}

class ImageAdapter extends TypeAdapter<Image> {
  @override
  int get typeId => 6; // You can set a unique typeId for each type adapter.

  @override
  Image read(BinaryReader reader) {
    final Map<String, dynamic> jsonData = json.decode(reader.read());
    return Image.fromJson(jsonData);
  }

  @override
  void write(BinaryWriter writer, Image obj) {
    final jsonString = json.encode(obj.toJson());
    writer.write(jsonString);
  }
}

void registerHiveAdapters() {
  Hive.registerAdapter(MenusModelAdapter());
  Hive.registerAdapter(MenuElementAdapter());
  Hive.registerAdapter(MenuMenuAdapter());
  Hive.registerAdapter(ProductElementAdapter());
  Hive.registerAdapter(PricingAdapter());
  Hive.registerAdapter(ProductProductAdapter());
  Hive.registerAdapter(ImageAdapter());
}
