import 'package:dio/dio.dart';
import 'package:pollution_environment/new_base/configs/app_config.dart';
import 'package:pollution_environment/new_base/network/aqi_client.dart';
import 'api_client.dart';
import 'api_interceptors.dart';

class ManagerApi {
  late final Dio dio;
  late final Dio aqiDio;
  late final ApiClient apiClient;
  late final AqiClient aqiClient;

  static final ManagerApi instance = ManagerApi._privateConstructor();

  ManagerApi._privateConstructor() {
    dio = Dio();
    dio.options.baseUrl = AppConfig.baseUrl;
    dio.interceptors.add(ApiInterceptors());
    dio.options.connectTimeout = const Duration(minutes: 3).inMilliseconds;
    dio.options.receiveTimeout = const Duration(minutes: 3).inMilliseconds;
    apiClient = ApiClient(dio, baseUrl: AppConfig.baseUrl);

    aqiDio = Dio();
    aqiDio.options.baseUrl = AppConfig.waqiUrl;
    aqiDio.interceptors.add(ApiInterceptors());
    aqiDio.options.connectTimeout = const Duration(minutes: 3).inMilliseconds;
    aqiDio.options.receiveTimeout = const Duration(minutes: 3).inMilliseconds;
    aqiClient = AqiClient(aqiDio, baseUrl: AppConfig.waqiUrl);
  }
}

