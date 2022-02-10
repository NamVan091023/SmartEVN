import 'package:get/get.dart';
import 'package:pollution_environment/src/model/pollution_position_model.dart';

class FilterMapController extends GetxController {
  final String ALL = 'Tất cả';
  List<PollutionPosition> pollutions = [];
  List<PollutionPosition> result = [];
  List<String?> cities = <String?>[];
  List<String?> districts = <String?>[];
  String? selectedCity = 'Tất cả';
  String? selectedDistrict = "Tất cả";
  String selectedPollution = "Tất cả";
}
