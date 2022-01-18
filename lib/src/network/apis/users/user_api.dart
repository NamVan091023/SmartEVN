import 'dart:async';

import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/constants/endpoints.dart';
import 'package:pollution_environment/src/network/dio_client.dart';
import 'package:pollution_environment/src/network/rest_client.dart';

class UserApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  UserApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<UserData> login() async {
    try {
      final res = await _dioClient.get(Endpoints.login);
      return UserData.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// sample api call with default rest client
//  Future<PostsList> getPosts() {
//
//    return _restClient
//        .get(Endpoints.getPosts)
//        .then((dynamic res) => PostsList.fromJson(res))
//        .catchError((error) => throw NetworkException(message: error));
//  }

}
