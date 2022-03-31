import 'package:get/get.dart';
import 'package:pollution_environment/src/model/address_model.dart';
import 'package:pollution_environment/src/model/pollution_quality_model.dart';
import 'package:pollution_environment/src/model/pollution_type_model.dart';
import 'package:pollution_environment/src/network/apis/pollution/pollution_api.dart';
import 'package:pollution_environment/src/screen/map/map_controller.dart';

class FilterStorageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterStorageController>(() => FilterStorageController());
  }
}

class FilterStorageController extends GetxController {
  Rx<ProvinceModel?> selectedProvince =
      ProvinceModel(id: "-1", name: "Tất cả").obs;
  Rx<DistrictModel?> selectedDistrict =
      DistrictModel(id: "-1", name: "Tất cả").obs;
  Rx<WardModel?> selectedWard = WardModel(id: "-1", name: "Tất cả").obs;
  RxList<PollutionType> selectedType = RxList<PollutionType>();
  RxList<PollutionQuality> selectedQuality = RxList<PollutionQuality>();

  RxList<List<double>> polygon = RxList<List<double>>();

  RxList<double> bbox = RxList<double>();
  Rx<bool> isFilterAQI = true.obs;

  @override
  void onInit() async {
    selectedType.assignAll(await getPollutionTypes());
    selectedQuality.assignAll(await getPollutionQualities());
    MapController mapController = Get.find();
    mapController.getPollutionPosition();
    super.onInit();
  }

  Future<List<PollutionType>> getPollutionTypes() async {
    var response = await PollutionApi().getPollutionTypes();
    final data = response;
    return data;
  }

  Future<List<PollutionQuality>> getPollutionQualities() async {
    var response = await PollutionApi().getPollutionQualities();
    final data = response;
    return data;
  }
}
