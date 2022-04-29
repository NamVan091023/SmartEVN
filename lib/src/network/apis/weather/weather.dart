import 'package:pollution_environment/src/network/api_service.dart';

class WeatherPath {
  static String get = "";
  static String KEY_WEATHER = "856822fd8e22db5e1ba48c0e7d69844a";
  static String KEY_WEATHER_EDU = "6db548d642b465e35888b3b59fe17f95";
}

class WeatherAPI {
  late APIService apiService;

  WeatherAPI() {
    apiService = APIService();
  }
}
