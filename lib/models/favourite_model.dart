class FavouriteModel {
  late final bool status;
  late final Null message;
  late final Data data;

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = null;
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late final int currentPage;
  late final List<Product> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((e) {
      data.add(Product.fromJson(e));
    });
  }
}

class Product {
  late final int id;
  late final ProductData productData;
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productData = ProductData.fromJason(json['product']);
  }
}

class ProductData {
  late final int id;
  late final double price;
  late final double old_price;
  late final double discount;
  late final String image;
  late final String name;
  ProductData.fromJason(Map<String, dynamic> jason) {
    id = jason['id'];
    price = double.parse(jason['price'].toString());
    old_price = double.parse(jason['old_price'].toString());
    discount = double.parse(jason['discount'].toString());
    image = jason['image'];
    name = jason['name'];
  }
}
