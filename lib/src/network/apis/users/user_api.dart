import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pollution_environment/src/model/base_response.dart';
import 'package:pollution_environment/src/model/token_response.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/api_service.dart';

class UserAPIPath {
  static String login = "/auth/login";
  static String register = "/auth/register";
  static String refreshToken = "/auth/refresh-tokens";
}

class UserApi {
  late APIService apiService;

  UserApi() {
    apiService = APIService();
  }

  Future<UserResponse> login(String email, String password) async {
    Response response;
    try {
      response = await apiService.request(
          method: APIMethod.POST,
          endPoint: UserAPIPath.login,
          data: {"email": email, "password": password});

      BaseResponse baseResponse;
      baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.data == null) {
        // Login khong thanh cong
        throw Exception(baseResponse.message);
      } else {
        UserResponse userResponse = UserResponse.fromJson(baseResponse.data!);
        return userResponse;
      }
    } on DioError catch (e) {
      throw (e);
    }
  }

  Future<UserResponse> register(
      String name, String email, String password) async {
    Response response;
    try {
      response = await apiService.request(
          method: APIMethod.POST,
          endPoint: UserAPIPath.register,
          data: {"name": name, "email": email, "password": password});

      BaseResponse baseResponse;
      baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.data == null) {
        // Login khong thanh cong
        throw Exception(baseResponse.message);
      } else {
        UserResponse userResponse = UserResponse.fromJson(baseResponse.data!);
        return userResponse;
      }
    } on DioError catch (e) {
      throw (e);
    }
  }

  Future<TokensResponse> refreshToken(String token) async {
    Response response;
    try {
      response = await apiService.request(
          method: APIMethod.POST,
          endPoint: UserAPIPath.refreshToken,
          data: {"refreshToken": token});

      BaseResponse baseResponse;
      baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.data == null) {
        throw Exception(baseResponse.message);
      } else {
        TokensResponse tokenResponse =
            TokensResponse.fromJson(baseResponse.data!["tokens"]);
        return tokenResponse;
      }
    } on DioError catch (e) {
      throw (e);
    }
  }
}
