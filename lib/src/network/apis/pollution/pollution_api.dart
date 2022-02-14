import 'package:dio/dio.dart';
import 'package:pollution_environment/src/model/base_response.dart';
import 'package:pollution_environment/src/model/pollution_quality_model.dart';
import 'package:pollution_environment/src/model/pollution_response.dart';
import 'package:pollution_environment/src/model/pollution_type_model.dart';
import 'package:pollution_environment/src/network/api_service.dart';

class PollutionAPIPath {
  static String getPollutionTypes = "/pollutions/types";
  static String getPollutionQualities = "/pollutions/qualities";
  static String getPollution = "/pollutions";
  static String updatePollution = "/pollutions";
}

class PollutionApi {
  late APIService apiService;

  PollutionApi() {
    apiService = APIService();
  }
  Future<List<PollutionType>> getPollutionTypes() async {
    Response response;
    try {
      response = await apiService.request(
        method: APIMethod.GET,
        endPoint: PollutionAPIPath.getPollutionTypes,
      );

      BaseArrayResponse baseResponse;
      baseResponse = BaseArrayResponse.fromJson(response.data);
      if (baseResponse.data == null) {
        throw Exception(baseResponse.message);
      } else {
        List<PollutionType> data = <PollutionType>[];
        baseResponse.data?.forEach((v) {
          data.add(new PollutionType.fromJson(v));
        });
        return data;
      }
    } on DioError catch (e) {
      throw (e);
    }
  }

  Future<List<PollutionQuality>> getPollutionQualities() async {
    Response response;
    try {
      response = await apiService.request(
        method: APIMethod.GET,
        endPoint: PollutionAPIPath.getPollutionQualities,
      );

      BaseArrayResponse baseResponse;
      baseResponse = BaseArrayResponse.fromJson(response.data);
      if (baseResponse.data == null) {
        throw Exception(baseResponse.message);
      } else {
        List<PollutionQuality> data = <PollutionQuality>[];
        baseResponse.data?.forEach((v) {
          data.add(new PollutionQuality.fromJson(v));
        });
        return data;
      }
    } on DioError catch (e) {
      throw (e);
    }
  }

  Future<PollutionsResponse> getAllPollution(
      {List<String>? type,
      String? provinceName,
      String? districtName,
      String? wardName,
      List<String>? quality,
      String? userId,
      int? limit,
      int? page}) async {
    Response response;
    Map<String, String> data = {};

    if (type != null && type.isNotEmpty) {
      for (int i = 0; i < type.length; i++) data["type[$i]"] = type[i];
    }
    if (provinceName != null && provinceName != '')
      data["provinceName"] = provinceName;
    if (districtName != null && districtName != '')
      data["districtName"] = districtName;
    if (quality != null && quality.isNotEmpty) {
      for (int i = 0; i < quality.length; i++) data["quality[$i]"] = quality[i];
    }
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
