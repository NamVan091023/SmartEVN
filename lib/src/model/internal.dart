import 'package:event_bus/event_bus.dart';
import 'package:pollution_environment/src/model/pollution_position_model.dart';

class Internal {
  static Internal _instance = new Internal.internal();

  Internal.internal();
  factory Internal() => _instance;

  List<PollutionPosition> listPosition = [];

  final eventBus = EventBus(sync: true);
}
