import 'package:dio/dio.dart';
import 'package:pollution_environment/new_base/configs/app_config.dart';
import 'package:pollution_environment/new_base/models/entities/address_model.dart';
import 'package:pollution_environment/new_base/models/entities/alert_model.dart';
import 'package:pollution_environment/new_base/models/entities/area_forest_model.dart';
import 'package:pollution_environment/new_base/models/entities/base_response.dart';
import 'package:pollution_environment/new_base/models/entities/news_model.dart';
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
}
