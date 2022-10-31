class CatagoriesModel {
  late final bool status;
  late final CatagoriesDataModel data;
  CatagoriesModel.fromJason(Map<String, dynamic> jason) {
    status = jason['status'];
    data = CatagoriesDataModel.fromJason(jason['data']);
  }
}

class CatagoriesDataModel {
  late final current_page;
  late final List<CatagoryDataModel> data;
  CatagoriesDataModel.fromJason(Map<String, dynamic> jason) {
    current_page = jason['current_page'];
    data = List.from(jason['data'])
        .map((e) => CatagoryDataModel.frimJason(e))
        .toList();
  }
}

class CatagoryDataModel {
  late final int id;
  late final name;
  late final String image;
  CatagoryDataModel.frimJason(Map<String, dynamic> jason) {
    id = jason['id'];
    name = jason['name'];
    image = jason['image'];
  }
}
