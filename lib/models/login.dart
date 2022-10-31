class LoginModel {
  bool? status;
  String? message;
  UserData? data;
  LoginModel.fromJson(Map<String, dynamic> json) {
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
  int? points;
  int? credit;
  String? token;
  UserData.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      name = json['name'];
      email = json['email'];
      phone = json['phone'];
      image = json['image'];
      points = json['points'];
      credit = json['credit'];
      token = json['token'];
    } else {
      id = null;
      name = null;
      email = null;
      phone = null;
      image = null;
      points = null;
      credit = null;
      token = null;
    }
  }
}
