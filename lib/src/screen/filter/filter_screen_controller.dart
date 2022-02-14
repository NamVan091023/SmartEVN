import 'package:get/get.dart';
import 'package:pollution_environment/src/model/address_model.dart';
import 'package:pollution_environment/src/model/pollution_quality_model.dart';
import 'package:pollution_environment/src/model/pollution_type_model.dart';
import 'package:pollution_environment/src/network/apis/address/address_api.dart';
import 'package:pollution_environment/src/network/apis/pollution/pollution_api.dart';
import 'package:pollution_environment/src/screen/filter/filter_storage_controller.dart';

class FilterMapController extends GetxController {
  RxList<ProvinceModel> provinces =
      [ProvinceModel(id: "-1", name: "Tất cả")].obs;
  RxList<DistrictModel> districts =
      [DistrictModel(id: "-1", name: "Tất cả")].obs;
  RxList<WardModel> wards = [WardModel(id: "-1", name: "Tất cả")].obs;

  Rx<ProvinceModel?> selectedProvince =
      ProvinceModel(id: "-1", name: "Tất cả").obs;
  Rx<DistrictModel?> selectedDistrict =
      DistrictModel(id: "-1", name: "Tất cả").obs;
  Rx<WardModel?> selectedWard = WardModel(id: "-1", name: "Tất cả").obs;
  RxList<PollutionType> selectedType = RxList<PollutionType>();
  RxList<PollutionQuality> selectedQuality = RxList<PollutionQuality>();

  @override
  void onInit() {
    super.onInit();

    final FilterStorageController filterStorageController = Get.find();
    selectedProvince.value = filterStorageController.selectedProvince.value;
    selectedDistrict.value = filterStorageController.selectedDistrict.value;
    selectedWard.value = filterStorageController.selectedWard.value;
    selectedQuality.value = filterStorageController.selectedQuality.toList();
    selectedType.value = filterStorageController.selectedType.toList();
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

  Future<List<ProvinceModel>> getData() async {
    var response = await AddressApi().getAllAddress();
    final data = response.data;
    return data ?? [];
  }

  void saveProvince(ProvinceModel? provinceModel) {
    selectedProvince.value = provinceModel;
    selectedDistrict.value = DistrictModel(id: "-1", name: "Tất cả");
    districts.value = getDistricts();

    selectedWard.value = WardModel(id: "-1", name: "Tất cả");
    wards.value = getWards();
  }

  void saveDistrict(DistrictModel? districtModel) {
    selectedDistrict.value = districtModel;
    selectedWard.value = WardModel(id: "-1", name: "Tất cả");
    wards.value = getWards();
  }

  void saveWard(WardModel? wardModel) {
    selectedWard.value = wardModel;
  }

  void saveType(List<PollutionType> pollutionType) {
    selectedType.value = pollutionType;
  }

  void saveQuality(List<PollutionQuality> pollutionQulities) {
    selectedQuality.value = pollutionQulities;
  }

  List<DistrictModel> getDistricts() {
    List<DistrictModel> districts = [DistrictModel(id: "-1", name: "Tất cả")];

    districts.addAll(selectedProvince.value?.districts ?? []);
    return districts;
  }

  List<WardModel> getWards() {
    List<WardModel> wards = [WardModel(id: "-1", name: "Tất cả")];

    wards.addAll(selectedDistrict.value?.wards ?? []);
    return wards;
  }

  void saveFilter() {
    final FilterStorageController filterStorageController = Get.find();
    filterStorageController.selectedDistrict.value = selectedDistrict.value;
    filterStorageController.selectedProvince.value = selectedProvince.value;
    filterStorageController.selectedWard.value = selectedWard.value;
    filterStorageController.selectedQuality.value = selectedQuality.toList();
    filterStorageController.selectedType.value = selectedType.toList();
  }
}
