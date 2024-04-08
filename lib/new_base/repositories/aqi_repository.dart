import 'package:pollution_environment/new_base/configs/app_config.dart';
import 'package:pollution_environment/new_base/models/entities/waqi_ip_model.dart';
import 'package:pollution_environment/new_base/models/entities/waqi_map_model.dart';
import 'package:pollution_environment/new_base/network/aqi_client.dart';

abstract class AqiRepository {
  Future<WAQIMapResponse?> getAQIMap({
    required double lat1,
    required double lng1,
    required double lat2,
    required double lng2,
  });

  Future<WAQIIpResponse?> getAQIByIP();

  Future<WAQIIpResponse?> getAQIByGPS({
    required double lat,
    required double lng,
  });

  Future<WAQIIpResponse?> getAQIById(int id);
}

class AqiRepositoryImpl extends AqiRepository {
  late AqiClient _aqiClient;

  AqiRepositoryImpl(AqiClient client) {
    _aqiClient = client;
  }

  @override
  Future<WAQIMapResponse?> getAQIMap({
    required double lat1,
    required double lng1,
    required double lat2,
    required double lng2,
  }) {
    return _aqiClient.getAQIMap(
      networks: "all",
      token: AppConfig.aqiToken,
      latlng: "$lat1,$lng1,$lat2,$lng2",
    );
  }

  @override
  Future<WAQIIpResponse?> getAQIByIP() {
    return _aqiClient.getAQIByIP(
      token: AppConfig.aqiToken,
    );
  }

  @override
  Future<WAQIIpResponse?> getAQIByGPS({
    required double lat,
    required double lng,
  }) {
    return _aqiClient.getAQIByGPS(
      token: AppConfig.aqiToken,
      lat: lat,
      lng: lng,
    );
  }

  @override
  Future<WAQIIpResponse?> getAQIById(int id) {
    return _aqiClient.getAQIById(
      token: AppConfig.aqiToken,
      id: id,
    );
  }
}
