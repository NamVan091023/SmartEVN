import 'package:dio/dio.dart';
import 'package:pollution_environment/new_base/configs/app_config.dart';
import 'package:pollution_environment/new_base/models/entities/waqi_ip_model.dart';
import 'package:pollution_environment/new_base/models/entities/waqi_map_model.dart';
import 'package:retrofit/retrofit.dart';

part 'aqi_client.g.dart';

@RestApi(baseUrl: AppConfig.waqiUrl)
abstract class AqiClient {
  factory AqiClient(Dio dio, {String baseUrl}) = _AqiClient;

  @GET('/v2/map/bounds')
  Future<WAQIMapResponse?> getAQIMap({
    @Query("networks") String? networks,
    @Query("token") String? token,
    @Query("latlng") String? latlng,
  });

  @GET('/feed/here')
  Future<WAQIIpResponse?> getAQIByIP({
    @Query("token") String? token,
  });

  @GET('/feed/geo:{lat};{lng}')
  Future<WAQIIpResponse?> getAQIByGPS({
    @Query("token") String? token,
    @Path("lat") double? lat,
    @Path("lng") double? lng,
  });

  @GET('/feed/@{id}')
  Future<WAQIIpResponse?> getAQIById({
    @Query("token") String? token,
    @Query("id") int? id,
  });
}
