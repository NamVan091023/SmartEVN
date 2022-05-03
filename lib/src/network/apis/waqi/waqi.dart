import 'package:dio/dio.dart';
import 'package:pollution_environment/src/model/waqi/waqi_ip_model.dart';
import 'package:pollution_environment/src/model/waqi/waqi_map_model.dart';
import 'package:pollution_environment/src/network/api_service.dart';

class WaqiAPIPath {
  static String getAqiMap = "/v2/map/bounds";

  static String TOKEN = "969cd16cfb9b40580a41aba8a4a0e9339f0f197a";
}

class WaqiAPI {
  late APIService apiService;

  WaqiAPI() {
    apiService = APIService();
  }

  Future<WAQIMapResponse> getAQIMap(
      double lat1, double lng1, double lat2, double lng2) async {
    Response response;
    try {
      response = await Dio(BaseOptions(
              baseUrl: "https://api.waqi.info",
              connectTimeout: 16000,
              receiveTimeout: 16000,
              sendTimeout: 16000))
          .request(WaqiAPIPath.getAqiMap, queryParameters: {
        "networks": "all",
        "token": WaqiAPIPath.TOKEN,
        "latlng": "$lat1,$lng1,$lat2,$lng2",
      });
      WAQIMapResponse aqiMapResponse = WAQIMapResponse.fromJson(response.data);
      return aqiMapResponse;
    } on DioError catch (e) {
      throw (e);
    }
  }

  Future<WAQIIpResponse> getAQIByIP() async {
    Response response;
    try {
      response = await Dio(BaseOptions(
              baseUrl: "https://api.waqi.info",
              connectTimeout: 16000,
              receiveTimeout: 16000,
              sendTimeout: 16000))
          .request("/feed/here/", queryParameters: {
        "token": WaqiAPIPath.TOKEN,
      });
      WAQIIpResponse aqiCurentResponse = WAQIIpResponse.fromJson(response.data);
      return aqiCurentResponse;
    } on DioError catch (e) {
      throw (e);
    }
  }

  Future<WAQIIpResponse> getAQIByGPS(double lat, double lng) async {
    Response response;
    try {
      response = await Dio(BaseOptions(
              baseUrl: "https://api.waqi.info",
              connectTimeout: 16000,
              receiveTimeout: 16000,
              sendTimeout: 16000))
          .request("/feed/geo:${lat};${lng}", queryParameters: {
        "token": WaqiAPIPath.TOKEN,
      });
      WAQIIpResponse aqiCurentResponse = WAQIIpResponse.fromJson(response.data);
      return aqiCurentResponse;
    } on DioError catch (e) {
      throw (e);
    }
  }

  Future<WAQIIpResponse> getAQIById(int id) async {
    Response response;
    try {
      response = await Dio(BaseOptions(
              baseUrl: "https://api.waqi.info",
              connectTimeout: 16000,
              receiveTimeout: 16000,
              sendTimeout: 16000))
          .request("/feed/@$id", queryParameters: {
        "token": WaqiAPIPath.TOKEN,
      });
      WAQIIpResponse aqiCurentResponse = WAQIIpResponse.fromJson(response.data);
      return aqiCurentResponse;
    } on DioError catch (e) {
      throw (e);
    }
  }
}
