class SearchModel {
  late final bool status;
  late final Null message;
  late final Data data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = null;
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late final int currentPage;
  late final List<ProductData> dataList;
  late final String firstPageUrl;
  late final int from;
  late final int lastPage;
  late final String lastPageUrl;
  late final Null nextPageUrl;
  late final String path;
  late final int perPage;
  late final Null prevPageUrl;
  late final int to;
  late final int total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    dataList =
        List.from(json['data']).map((e) => ProductData.fromJson(e)).toList();
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = null;
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = null;
    to = json['to'];
    total = json['total'];
  }
}

class ProductData {
  late int id;
  late double price;
  late String image;
  late String name;
  late String description;
  late bool in_favorites;
  late bool in_cart;
  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = double.parse(json['price'].toString());
    image = json['image'];
    name = json['name'];
    description = json['description'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
