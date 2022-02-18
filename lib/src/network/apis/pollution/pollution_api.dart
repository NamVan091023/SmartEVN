import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pollution_environment/src/model/base_response.dart';
import 'package:pollution_environment/src/model/pollution_quality_model.dart';
import 'package:pollution_environment/src/model/pollution_response.dart';
import 'package:pollution_environment/src/model/pollution_type_model.dart';
import 'package:pollution_environment/src/network/api_service.dart';

class PollutionAPIPath {
  static String getPollutionTypes = "/pollutions/types";
  static String getPollutionQualities = "/pollutions/qualities";
  static String getPollutionAuth = '/pollutions/me';
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
      int? status,
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
    if (status != null) data["status"] = '$status';
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
        PollutionsResponse pollutionsResponse =
            PollutionsResponse.fromJson(baseResponse.data!);
        return pollutionsResponse;
      }
    } on DioError catch (e) {
      throw (e);
    }
  }

  Future<PollutionsResponse> getPollutionAuth(
      {List<String>? type,
      String? provinceName,
      String? districtName,
      String? wardName,
      int? status,
      List<String>? quality,
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
    if (status != null) data["status"] = '$status';
    if (limit != null) data["limit"] = '$limit';
    if (page != null) data["page"] = '$page';

    try {
      response = await apiService.request(
        method: APIMethod.GET,
        endPoint: PollutionAPIPath.getPollutionAuth,
        data: data,
      );

      BaseResponse baseResponse;
      baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.data == null) {
        throw Exception(baseResponse.message);
      } else {
        PollutionsResponse pollutionsResponse =
            PollutionsResponse.fromJson(baseResponse.data!);
        return pollutionsResponse;
      }
    } on DioError catch (e) {
      throw (e);
    }
  }

  Future<PollutionModel> createPollution(
      {required String type,
      required String provinceName,
      required String provinceId,
      required String districtId,
      required String districtName,
      required String wardName,
      required String wardId,
      required String quality,
      required String desc,
      required String specialAddress,
      double? lat,
      double? lng,
      List<File>? files,
      Function(int, int)? onSendProgress}) async {
    Response response;
    Map<String, dynamic> data = {
      "type": type,
      "provinceName": provinceName,
      "provinceId": provinceId,
      "districtName": districtName,
      "districtId": districtId,
      "wardName": wardName,
      "wardId": wardId,
      "quality": quality,
      "desc": desc,
      "specialAddress": specialAddress
    };

    if (files != null) {
      List<MultipartFile> multipartImageList = [];
      for (var i = 0; i < files.length; i++) {
        var pic = MultipartFile.fromFileSync(
          files[i].path,
          filename: files[i].uri.toString(),
        );
        multipartImageList.add(pic);
      }
      if (multipartImageList.isNotEmpty) {
        data["images"] = multipartImageList;
      }
    }

    FormData formData = FormData.fromMap(data);

    try {
      response = await apiService.requestFormData(
          endPoint: PollutionAPIPath.updatePollution,
          data: formData,
          onSendProgress: onSendProgress);

      BaseResponse baseResponse;
      baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.data == null) {
        throw Exception(baseResponse.message);
      } else {
        PollutionModel pollutionModel =
            PollutionModel.fromJson(baseResponse.data!);
        return pollutionModel;
      }
    } on DioError catch (e) {
      throw (e);
    }
  }
}
