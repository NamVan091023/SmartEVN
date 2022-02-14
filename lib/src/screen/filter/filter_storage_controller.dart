import 'package:get/get.dart';
import 'package:pollution_environment/src/model/address_model.dart';
import 'package:pollution_environment/src/model/pollution_quality_model.dart';
import 'package:pollution_environment/src/model/pollution_type_model.dart';

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
}
