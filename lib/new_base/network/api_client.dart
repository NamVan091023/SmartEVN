import 'package:dio/dio.dart';
import 'package:pollution_environment/new_base/configs/app_config.dart';
import 'package:pollution_environment/new_base/models/entities/address_model.dart';
import 'package:pollution_environment/new_base/models/entities/alert_model.dart';
import 'package:pollution_environment/new_base/models/entities/area_forest_model.dart';
import 'package:pollution_environment/new_base/models/entities/base_response.dart';
import 'package:pollution_environment/new_base/models/entities/news_model.dart';
import 'package:pollution_environment/new_base/models/entities/area_forest_model.dart';
import 'package:pollution_environment/new_base/models/entities/base_response.dart';
import 'package:pollution_environment/new_base/models/entities/news_model.dart';
import 'package:pollution_environment/new_base/models/entities/pollution_quality_model.dart';
import 'package:pollution_environment/new_base/models/entities/pollution_response.dart';
import 'package:pollution_environment/new_base/models/entities/pollution_stats.dart';
import 'package:pollution_environment/new_base/models/entities/pollution_type_model.dart';
import 'package:pollution_environment/new_base/models/responses/alert_response.dart';
import 'package:pollution_environment/new_base/models/responses/data_response.dart';
import 'package:pollution_environment/new_base/models/responses/list_data_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: AppConfig.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

/*  @GET('/data/2.5/weather')
  Future<InfoWeatherEntity> getWeatherByCityName({
    @Query("q") String? address,
    @Query("units") String? units,
    @Query("appid") String? appId,
  });

  @GET('/data/2.5/onecall')
  Future<WeatherByDayEntity> getWeatherByHour({
    @Query("lat") String? lat,
    @Query("lon") String? lon,
    @Query("exclude") String? exclude,
    @Query("units") String? units,
    @Query("appid") String? appId,
  });*/

  @GET('/address')
  Future<AddressModel?> getWeatherByHour();

  @GET('/address/parse')
  Future<ParseAddressResponse?> parseAddress({
    @Query("lat") double? lat,
    @Query("lng") double? lon,
  });

  @GET('/iqair/area-forest')
  Future<List<AreaForestModel>?> getAreaForest();

  @GET('/iqair')
  Future<List<IQAirRankVN>?> getRankVN();

  @GET('/alert')
  Future<AlertResponse?> getAlerts({
    @Query("page") int? page,
    @Query("limit") int? limit,
    @Query("type") String? type,
    @Query("sortBy") String? sortBy,
  });

  @POST('/alert')
  Future<BaseResponse?> createAlert();

  @GET('/news')
  Future<NewsResponse?> getNews({
    @Query("page") int? page,
    @Query("limit") int? limit,
    @Query("type") String? type,
  });

  @GET('/pollutions/types')
  Future<ListDataResponse<PollutionType>?> getPollutionTypes();

  @GET('/pollutions/qualities')
  Future<ListDataResponse<PollutionQuality>?> getPollutionQualities();

  @GET('/pollutions')
  Future<DataResponse<PollutionsResponse>?> getAllPollution({
    @Query("type") List<String>? type,
    @Query("provinceName") String? provinceName,
    @Query("districtName") String? districtName,
    @Query("wardName") String? wardName,
    @Query("provinceIds") List<String>? provinceIds,
    @Query("districtIds") List<String>? districtIds,
    @Query("wardIds") List<String>? wardIds,
    @Query("status") int? status,
    @Query("quality") List<String>? quality,
    @Query("searchText") String? searchText,
    @Query("userId") String? userId,
    @Query("limit") int? limit,
    @Query("page") int? page,
    @Query("startDate") String? startDate,
    @Query("endDate") String? endDate,
  });

  @GET('/pollutions/me')
  Future<DataResponse<PollutionsResponse>?> getPollutionAuth({
    @Query("type") List<String>? type,
    @Query("provinceName") String? provinceName,
    @Query("districtName") String? districtName,
    @Query("wardName") String? wardName,
    @Query("status") int? status,
    @Query("quality") List<String>? quality,
    @Query("limit") int? limit,
    @Query("page") int? page,
    @Query("startDate") String? sortBy,
  });

  @GET('/pollutions/user')
  Future<DataResponse<PollutionsResponse>?> getPollutionByUser({
    @Query("userId") String? userId,
    @Query("limit") int? limit,
    @Query("page") int? page,
    @Query("startDate") String? sortBy,
  });

  @GET('/pollutions/{id}')
  Future<DataResponse<PollutionModel>?> getOnePollution({
    @Path("id") String? id,
  });

  @POST('/pollutions')
  Future<DataResponse<PollutionModel>?> createPollution({
    @Path("id") String? id,
  });

  @DELETE('/pollutions/{id}')
  Future<DataResponse<PollutionModel>?> deletePollution({
    @Path("id") String? id,
  });

  @PATCH('/pollutions/{id}')
  Future<DataResponse<PollutionModel>?> updatePollution({
    @Path("id") String? id,
    @Path("images") List<MultipartFile>? images,
  });

  @GET('/pollutions/stats')
  Future<DataResponse<PollutionStats>?> getPollutionStats();

  @GET('/pollutions/history')
  Future<ListDataResponse<PollutionModel>?> getPollutionHistory({
    @Query("districtId") String? districtId,
  });

}
