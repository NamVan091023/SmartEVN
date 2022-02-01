import 'package:dio/dio.dart';
import 'package:pollution_environment/src/model/base_response.dart';

enum APIMethod { GET, POST, PUT, PATCH, DELETE }

class APIService {
  late Dio _dio;

  final baseUrl = "http://10.8.0.2:3000/v1";

  APIService() {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));

    initializeInterceptors();
  }

  Future<Response> request(
      {required APIMethod method, required String endPoint, Map? data}) async {
    Response response;

    try {
      switch (method) {
        case APIMethod.POST:
          response = await _dio.post(endPoint, data: data);
          break;
        case APIMethod.PUT:
          response = await _dio.put(endPoint, data: data);
          break;
        case APIMethod.PATCH:
          response = await _dio.patch(endPoint, data: data);
          break;
        case APIMethod.DELETE:
          response = await _dio.delete(endPoint, data: data);
          break;
        default:
          response = await _dio.get(endPoint);
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.response:
          BaseResponse baseResponse = BaseResponse.fromJson(e.response?.data);
          throw Exception(baseResponse.message ?? e.message);
        case DioErrorType.connectTimeout:
          throw Exception("Quá thời gian kết nối");
        case DioErrorType.receiveTimeout:
          throw Exception("Quá thời gian chờ");
        case DioErrorType.other:
          throw Exception("Lỗi không xác định\n${e.message}");
        default:
          throw Exception(e.message);
      }
    } catch (e) {
      throw Exception("Đã có lỗi xảy ra, vui lòng thử lại.");
    }
    return response;
  }

  initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError e, handler) {
        print(e.message);
        return handler.next(e);
      },
      onRequest: (options, handler) {
        print("${options.method} ${options.path}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print(response.data);
        return handler.next(response);
      },
    ));
  }
}
