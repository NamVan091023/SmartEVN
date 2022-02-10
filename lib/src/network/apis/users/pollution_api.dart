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

  Future<PollutionsResponse> getAllPollution(
      {String? type,
      String? provinceName,
      String? districtName,
      String? quality,
      String? userId,
      int? limit,
      int? page}) async {
    Response response;
    Map<String, String> data = {};

    if (type != null && type != '') data["type"] = type;
    if (provinceName != null && provinceName != '')
      data["provinceName"] = provinceName;
    if (districtName != null && districtName != '')
      data["districtName"] = districtName;
    if (quality != null && quality != '') data["quality"] = quality;
    if (userId != null && userId != '') data["userId"] = userId;
    if (limit != null) data["limit"] = '$limit';
    if (page != null) data["page"] = '$page';

    try {
      response = await apiService.request(
        method: APIMethod.GET,
        endPoint: PollutionAPIPath.getPollution,
        data: data,
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
