import 'import :package:dio/dio.dart';
import 'package:pollution_environment/new_base/configs/app_config.dart'';
import 'package:pollution_environment/new_base/models/entities/weather_curent_model.dart';
import 'package:pollution_environment/new_base/models/entities/weather_daily_model.dart';
import 'package:pollution_environment/new_base/models/entities/weather_hourly_model.dart';
import 'package:retrofit/retrofit.dart';

@RestApi(baseUrl: AppConfig.wea)

