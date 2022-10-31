class UpdateUserDataModel {
  late bool status;
  late String message;
  late UserData data;
  UpdateUserDataModel.fromJson(Map<String, dynamic> json) {
    this.status = json['status'];
    this.message = json['message'];
    this.data = UserData.fromJson(json['data']);
  }
}

class UserData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;
  UserData.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
    this.phone = json['phone'];
    this.image = json['image'];
    this.points = json['points'];
    this.credit = json['credit'];
    this.token = json['token'];
  }
}
