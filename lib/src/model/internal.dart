import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/model/pollution_response.dart';

class Internal {
  static Internal _instance = new Internal.internal();

  Internal.internal();
  factory Internal() => _instance;

  RxList<PollutionModel> listPollution = RxList<PollutionModel>();

  final eventBus = EventBus(sync: true);
}
