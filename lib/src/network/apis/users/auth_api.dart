import 'dart:async';
import 'dart:ui';

import 'package:background_locator/background_locator.dart';
import 'package:dio/dio.dart';
import 'package:pollution_environment/src/commons/background_location/location_service_repository.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/sharedPresf.dart';
import 'package:pollution_environment/src/model/base_response.dart';
import 'package:pollution_environment/src/model/token_response.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/api_service.dart';

class AuthAPIPath {
  static String login = "/auth/login";
  static String register = "/auth/register";
  static String refreshToken = "/auth/refresh-tokens";
  static String logout = "/auth/logout";
}

class AuthApi {
  late APIService apiService;

  AuthApi() {
    apiService = APIService();
  }

  Future<AuthResponse> login(String email, String password) async {
    Response response;
    try {
      response = await apiService.request(
          method: APIMethod.POST,
          endPoint: AuthAPIPath.login,
          data: {"email": email, "password": password},
          options: Options(headers: {"requiresToken": false, "isLogin": true}));

      BaseResponse baseResponse;
      baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.data == null) {
        // Login khong thanh cong
        throw Exception(baseResponse.message);
      } else {
        AuthResponse authResponse = AuthResponse.fromJson(baseResponse.data!);
        return authResponse;
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<AuthResponse> register(
      String name, String email, String password) async {
    Response response;
    try {
      response = await apiService.request(
          method: APIMethod.POST,
          endPoint: AuthAPIPath.register,
          data: {"name": name, "email": email, "password": password},
          options: Options(headers: {"requiresToken": false}));

      BaseResponse baseResponse;
      baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.data == null) {
        // Login khong thanh cong
        throw Exception(baseResponse.message);
      } else {
        AuthResponse authResponse = AuthResponse.fromJson(baseResponse.data!);
        return authResponse;
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
          endPoint: AuthAPIPath.refreshToken,
          data: {"refreshToken": token},
          options: Options(headers: {"requiresToken": false}));

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

  Future<BaseResponse> logout() async {
    Response response;
    try {
      response = await apiService.request(
          method: APIMethod.POST,
          endPoint: AuthAPIPath.logout,
          data: {
            "refreshToken": PreferenceUtils.getString(KEY_REFRESH_TOKEN),
          },
          options: Options(headers: {"requiresToken": false}));

      BaseResponse baseResponse = BaseResponse.fromJson(response.data);
      return baseResponse;
    } on DioError catch (e) {
      throw (e);
    }
  }

  void clearUserData() {
    PreferenceUtils.remove(KEY_ACCESS_TOKEN);
    PreferenceUtils.remove(KEY_REFRESH_TOKEN);
    PreferenceUtils.remove(KEY_USER_ID);
    PreferenceUtils.remove(KEY_IS_ADMIN);
    IsolateNameServer.removePortNameMapping(
        LocationServiceRepository.isolateName);
    BackgroundLocator.unRegisterLocationUpdate();
  }
}