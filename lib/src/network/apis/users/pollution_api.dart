import 'package:dio/dio.dart';
import 'package:pollution_environment/src/model/base_response.dart';
import 'package:pollution_environment/src/model/pollution_response.dart';
import 'package:pollution_environment/src/network/api_service.dart';

class PollutionAPIPath {
  static String getPollution = "/pollutions";
  static String updatePollution = "/pollutions";
}

class PollutionApi {
  late APIService apiService;

  PollutionApi() {
    apiService = APIService();
  }

  Future<PollutionsResponse> getAllPollution(String? type, String? provinceName,
      String? districtName, String? quality, String? userId) async {
    Response response;
    try {
      response = await apiService.request(
        method: APIMethod.GET,
        endPoint: PollutionAPIPath.getPollution,
        data: {
          "type": type,
          "provinceName": provinceName,
          "districtName": districtName,
          "quality": quality,
          "userId": userId,
        },
      );

      BaseResponse baseResponse;
      baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.data == null) {
        throw Exception(baseResponse.message);
      } else {
        PollutionsResponse userResponse =
            PollutionsResponse.fromJson(baseResponse.data!);
        return userResponse;
      }
    } on DioError catch (e) {
      throw (e);
    }
  }
}
