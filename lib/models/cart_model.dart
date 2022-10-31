class CartModel {
  late final bool status;
  late final Null message;
  late final Data data;

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = null;
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late List<CartItems> cartItems = [];

  late final double total;

  Data.fromJson(Map<String, dynamic> json) {
    cartItems = List.from(json['cart_items'])
        .map((e) => CartItems.fromJson(e))
        .toList();
    total = double.parse(json['total'].toString());
  }
}

class CartItems {
  late int id;

  late Product product;

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    product = Product.fromJson(json['product']);
  }
}

class Product {
  late int id;
  late double price;
  late double oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;
  late bool inFavorites;
  late bool inCart;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = double.parse(json['price'].toString());
    oldPrice = double.parse(json['old_price'].toString());
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
