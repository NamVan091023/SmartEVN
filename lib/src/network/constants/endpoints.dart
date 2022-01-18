class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://127.0.0.1";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String login = baseUrl + "/v1/auth/login";
}
