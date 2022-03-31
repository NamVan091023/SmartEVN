import 'package:pollution_environment/src/model/token_response.dart';

class AuthResponse {
  UserModel? user;
  TokensResponse? tokens;

  AuthResponse.fromJson(Map<String, dynamic> json) {
    user = UserModel.fromJson(json['user']);
    tokens = TokensResponse.fromJson(json['tokens']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['tokens'] = this.tokens;
    return data;
  }
}

class UserListResponse {
  List<UserModel>? results;
  int? page;
  int? limit;
  int? totalPages;
  int? totalResults;

  UserListResponse(
      {this.results,
      this.page,
      this.limit,
      this.totalPages,
      this.totalResults});

  UserListResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <UserModel>[];
      json['results'].forEach((v) {
        results!.add(new UserModel.fromJson(v));
      });
    }
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    totalResults = json['totalResults'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['totalPages'] = this.totalPages;
    data['totalResults'] = this.totalResults;
    return data;
  }
}

class UserModel {
  String? role;
  bool? isEmailVerified;
  String? email;
  String? name;
  String? id;
  String? createdAt;
  String? avatar;
  bool? isNotificationReceived;
  int post = 0;

  UserModel({this.name});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    isEmailVerified = json['isEmailVerified'];
    isNotificationReceived = json['isNotificationReceived'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['isEmailVerified'] = this.isEmailVerified;
    data['isNotificationReceived'] = this.isNotificationReceived;
    data['email'] = this.email;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['avatar'] = this.avatar;
    return data;
  }
}
