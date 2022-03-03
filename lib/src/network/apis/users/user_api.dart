import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pollution_environment/src/model/base_response.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/api_service.dart';

class UserAPIPath {
  static String getUserById = "/users";
}

class UserAPI {
  late APIService apiService;

  UserAPI() {
    apiService = APIService();
  }

  Future<UserModel> getUserById(String id) async {
    Response response;
    try {
      response = await apiService.request(
        method: APIMethod.GET,
        endPoint: "${UserAPIPath.getUserById}/$id",
      );

      BaseResponse baseResponse;
      baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.data == null) {
        throw Exception(baseResponse.message);
      } else {
        UserModel userModel = UserModel.fromJson(baseResponse.data!);
        return userModel;
      }
    } on DioError catch (e) {
      throw (e);
    }
  }

  Future<UserModel> updateNotificationReceived(
      {required String id, required bool isReceived}) async {
    Response response;
    Map<String, dynamic> data = {};
    data["isNotificationReceived"] = isReceived;

    FormData formData = FormData.fromMap(data);

    try {
      response = await apiService.requestFormData(
        endPoint: "${UserAPIPath.getUserById}/$id",
        data: formData,
        method: APIMethod.PATCH,
      );

      BaseResponse baseResponse;
      baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.data == null) {
        throw Exception(baseResponse.message);
      } else {
        UserModel userModel = UserModel.fromJson(baseResponse.data!);
        return userModel;
      }
    } on DioError catch (e) {
      throw (e);
    }
  }

  Future<UserModel> updateUser(
      {required String id,
      String? name,
      String? email,
      String? password,
      File? avatar}) async {
    Response response;
    Map<String, dynamic> data = {};
    if (name != null) data["name"] = name;
    if (email != null) data["email"] = email;
    if (password != null) data["password"] = password;
    if (avatar != null) {
      var pic = MultipartFile.fromFileSync(
        avatar.path,
        filename: avatar.uri.toString(),
      );
      data["image"] = pic;
    }

    FormData formData = FormData.fromMap(data);

    try {
      response = await apiService.requestFormData(
        endPoint: "${UserAPIPath.getUserById}/$id",
        data: formData,
        method: APIMethod.PATCH,
      );

      BaseResponse baseResponse;
      baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.data == null) {
        throw Exception(baseResponse.message);
      } else {
        UserModel userModel = UserModel.fromJson(baseResponse.data!);
        return userModel;
      }
    } on DioError catch (e) {
      throw (e);
    }
  }
}
