import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/commons/location_service.dart';
import 'package:pollution_environment/src/model/address_model.dart';
import 'package:pollution_environment/src/model/pollution_quality_model.dart';
import 'package:pollution_environment/src/model/pollution_type_model.dart';
import 'package:pollution_environment/src/network/apis/address/address_api.dart';
import 'package:pollution_environment/src/network/apis/pollution/pollution_api.dart';
import 'package:geocoding/geocoding.dart';

class CreateReportController extends GetxController {
  RxList<File> images = RxList<File>();

  Rxn<ProvinceModel?> selectedProvince = Rxn<ProvinceModel?>();
  Rxn<DistrictModel?> selectedDistrict = Rxn<DistrictModel?>();
  Rxn<WardModel?> selectedWard = Rxn<WardModel?>();
  Rxn<PollutionType?> selectedType = Rxn<PollutionType?>();
  Rxn<PollutionQuality?> selectedQuality = Rxn<PollutionQuality?>();

  Rx<String?> specialAddress = null.obs;
  Rx<String?> description = null.obs;

  @override
  void onInit() {
    showLoading();
    LocationService().determinePosition().then((value) {
      double lat = value.latitude;
      double lng = value.longitude;
      AddressApi().parseAddress(lat, lng).then((value) {
        getDataProvince().then((provinces) {
          var province =
              provinces.firstWhere((element) => element.id == value.provinceId);
          selectedProvince.value = province;
          selectedDistrict.value = province.districts
              ?.firstWhere((element) => element.id == value.districtId);

          hideLoading();
        }).catchError((e) {
          hideLoading();
        });
      }).catchError((e) {
        hideLoading();
      });
    }).catchError((e) {
      hideLoading();
    });

    super.onInit();
  }

  Future<List<ProvinceModel>> getDataProvince() async {
    var response = await AddressApi().getAllAddress();
    final data = response.data;
    return data ?? [];
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

  void saveProvince(ProvinceModel? provinceModel) {
    selectedProvince.value = provinceModel;
    selectedDistrict.value = null;

    selectedWard.value = null;
  }

  void saveDistrict(DistrictModel? districtModel) {
    selectedDistrict.value = districtModel;
    selectedWard.value = null;
  }

  void saveWard(WardModel? wardModel) {
    selectedWard.value = wardModel;
  }

  void saveType(PollutionType? pollutionType) {
    selectedType.value = pollutionType;
  }

  void saveQuality(PollutionQuality? pollutionQulity) {
    selectedQuality.value = pollutionQulity;
  }

  void saveSpecialAddress(String? address) {
    specialAddress = address.obs;
  }

  void saveDescription(String? desc) {
    description = desc.obs;
  }

  List<DistrictModel> getDistricts() {
    List<DistrictModel> districts = [];

    districts.addAll(selectedProvince.value?.districts ?? []);
    return districts;
  }

  List<WardModel> getWards() {
    List<WardModel> wards = [];

    wards.addAll(selectedDistrict.value?.wards ?? []);
    return wards;
  }

  Future<void> createReport(Function(String) onError) async {
    double? lat;
    double? lng;
    try {
      List<Location> locations = await locationFromAddress(
          "$specialAddress, ${selectedWard.value?.name}, ${selectedDistrict.value?.name}, ${selectedProvince.value?.name}");
      if (locations.isEmpty) {
        locations = await locationFromAddress(
            "${selectedWard.value?.name}, ${selectedDistrict.value?.name}, ${selectedProvince.value?.name}");
      }
      if (locations.isEmpty) {
        locations = await locationFromAddress(
            "${selectedDistrict.value?.name}, ${selectedProvince.value?.name}");
      }
      if (locations.isEmpty) {
        locations =
            await locationFromAddress("${selectedProvince.value?.name}");
      }
      if (locations.isNotEmpty) {
        lat = locations.first.latitude;
        lng = locations.first.longitude;
      }
    } catch (e) {
      print(e);
    }
    // showLoading(text: "Đang tải...");
    await PollutionApi()
        .createPollution(
            type: selectedType.value!.key!,
            provinceName: selectedProvince.value!.name!,
            provinceId: selectedProvince.value!.id!,
            districtId: selectedDistrict.value!.id!,
            districtName: selectedDistrict.value!.name!,
            wardName: selectedWard.value!.name!,
            wardId: selectedWard.value!.id!,
            quality: selectedQuality.value!.key!,
            desc: description.value!,
            specialAddress: specialAddress.value!,
            lat: lat,
            lng: lng,
            files: images.toList(),
            onSendProgress: (sent, total) {
              showLoading(
                  text: "Đang tải lên ...", progress: 1.0 * sent / total);
            })
        .then((value) {
      hideLoading();
      Get.back();
      Fluttertoast.showToast(msg: "Tạo báo cáo thành công");
    }, onError: (e) {
      hideLoading();
      onError(e.message);
    });
  }
}
