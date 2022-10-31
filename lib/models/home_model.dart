class HomeModel {
  late bool status;
  late DataModel data;
  HomeModel.fromJason(Map<String, dynamic> jason) {
    status = jason['status'];
    data = DataModel.fromJason(jason['data']);
  }
}

class DataModel {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];
  DataModel.fromJason(Map<String, dynamic> jason) {
    jason['banners'].forEach((element) {
      banners.add(BannersModel.fromJason(element));
    });

    jason['products'].forEach((element) {
      products.add(ProductsModel.fromJason(element));
    });
  }
}

class BannersModel {
  late int id;
  late String image;
  BannersModel.fromJason(Map<String, dynamic> jason) {
    id = jason['id'];
    image = jason['image'];
  }
}

class ProductsModel {
  late int id;
  late double price;
  late double old_price;
  late String image;
  late int discount;
  late String name;
  late bool in_favorites;
  late bool in_cart;
  ProductsModel.fromJason(Map<String, dynamic> jason) {
    id = jason['id'];
    image = jason['image'];
    price = double.parse(jason['price'].toString());
    old_price = double.parse(jason['old_price'].toString());
    discount = jason['discount'];
    name = jason['name'];
    in_favorites = jason['in_favorites'];
    in_cart = jason['in_cart'];
    in_cart = jason['in_cart'];
  }
}
