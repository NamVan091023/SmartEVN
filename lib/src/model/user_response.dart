import 'package:pollution_environment/src/model/simple_respone.dart';

class UserModel extends SimpleResult {
  Data data;

  UserModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    errorCode = json['errorCode'];
    message = json['message'];
    data = new Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['message'] = this.message;
    data['data'] = this.data;

    return data;
  }
}

class Data {
  String name, avatar, email;
  int post, role;

  Data(this.name, this.avatar, this.email, this.post, this.role);

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    email = json['email'];
    post = json['post'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['post'] = this.post;
    data['role'] = this.role;
    return data;
  }
}
