import 'dart:ffi';

class ChangeFavouriteModel {
  late final bool status;
  late final String message;
  late final Data data;

  ChangeFavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late int id;
  late final Product product;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  late int id;
  late double price;
  late double oldPrice;
  late double discount;
  late dynamic image;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'].toDouble();
    oldPrice = json['old_price'].toDouble();
    discount = json['discount'].toDouble();

    image = json['image'];
  }
}
