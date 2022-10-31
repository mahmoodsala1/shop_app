class RegisterModel {
  late bool status;
  late dynamic message;
  UserData? data;
  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = UserData.fromJson(json['data']);
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;
  UserData.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      name = json['name'];
      email = json['email'];
      phone = json['phone'];
      image = json['image'];
      token = json['token'];
    } else {
      id = null;
      name = null;
      email = null;
      phone = null;
      image = null;
      token = null;
    }
  }
}
