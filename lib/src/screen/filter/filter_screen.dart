import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/components/default_button.dart';
import 'package:pollution_environment/src/model/address_model.dart';
import 'package:pollution_environment/src/model/pollution_quality_model.dart';
import 'package:pollution_environment/src/model/pollution_type_model.dart';
import 'package:pollution_environment/src/screen/filter/filter_screen_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';

class FilterMapScreen extends StatelessWidget {
  final FilterMapController _controller = Get.put(FilterMapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Get.back();
            }),
        title: Text('Lọc tìm kiếm',
            style: TextStyle(color: Colors.white, fontSize: titleTextSize)),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView(
          padding: EdgeInsets.all(4),
          children: <Widget>[
            _buildProvinceSelection(),
            SizedBox(
              height: 30,
            ),
            _buildDistrictSelection(),
            SizedBox(
              height: 30,
            ),
            _buildWardSelection(),
            SizedBox(
              height: 30,
            ),
            _buildTypeSelection(),
            SizedBox(
              height: 30,
            ),
            _buildQualitySelection(),
            SizedBox(
              height: 30,
            ),
            DefaultButton(
                text: 'Hoàn tất',
                press: () {
                  _controller.saveFilter();
                  Get.back();
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildProvinceSelection() {
    return Obx(() => DropdownSearch<ProvinceModel>(
          mode: Mode.MENU,
          onChanged: (item) => _controller.saveProvince(item),
          clearButtonSplashRadius: 20,
          showSelectedItems: true,
          compareFn: (item, selectedItem) => item?.id == selectedItem?.id,
          selectedItem: _controller.selectedProvince.value,
          showSearchBox: true,
          dropdownSearchDecoration: InputDecoration(
            labelText: "Tỉnh/Thành phố",
            hintText: "Chọn tỉnh/thành phố",
            contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
          ),
          itemAsString: (item) => item?.name ?? "",
          onFind: (String? filter) => _controller.getData(),
          items: _controller.provinces.toList(),
          maxHeight: 300,
          searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Nhập để tìm kiếm",
                  hintStyle: TextStyle(color: Colors.grey))),
          popupShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ));
  }

  Widget _buildDistrictSelection() {
    return Obx(() => DropdownSearch<DistrictModel>(
          mode: Mode.MENU,
          onChanged: (item) => _controller.saveDistrict(item),
          clearButtonSplashRadius: 20,
          showSelectedItems: true,
          compareFn: (item, selectedItem) => item?.id == selectedItem?.id,
          selectedItem: _controller.selectedDistrict.value,
          showSearchBox: true,
          dropdownSearchDecoration: InputDecoration(
            labelText: "Loại quận/huyện",
            hintText: "Chọn quận/huyện",
            contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
          ),
          itemAsString: (item) => item?.name ?? "",
          items: _controller.getDistricts(),
          maxHeight: 300,
          searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Nhập để tìm kiếm",
                  hintStyle: TextStyle(color: Colors.grey))),
          popupShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ));
  }

  Widget _buildWardSelection() {
    return Obx(() => DropdownSearch<WardModel>(
          mode: Mode.MENU,
          onChanged: (item) => _controller.saveWard(item),
          clearButtonSplashRadius: 20,
          showSelectedItems: true,
          compareFn: (item, selectedItem) => item?.id == selectedItem?.id,
          selectedItem: _controller.selectedWard.value,
          showSearchBox: true,
          dropdownSearchDecoration: InputDecoration(
            labelText: "Phường/Xã",
            hintText: "Chọn phường/xã",
            contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
          ),
          itemAsString: (item) => item?.name ?? "",
          items: _controller.getWards(),
          maxHeight: 300,
          searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Nhập để tìm kiếm",
                  hintStyle: TextStyle(color: Colors.grey))),
          popupShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ));
  }

  Widget _buildTypeSelection() {
    return Obx(() => DropdownSearch<PollutionType>.multiSelection(
          mode: Mode.MENU,
          onChanged: (item) => _controller.saveType(item),
          clearButtonSplashRadius: 20,
          showSelectedItems: true,
          compareFn: (item, selectedItem) => item?.key == selectedItem?.key,
          selectedItems: _controller.selectedType.toList(),
          showSearchBox: true,
          dropdownSearchDecoration: InputDecoration(
            labelText: "Loại ô nhiễm",
            hintText: "Chọn loại ô nhiễm",
            contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
          ),
          itemAsString: (item) => item?.name ?? "",
          onFind: (String? filter) => _controller.getPollutionTypes(),
          maxHeight: 300,
          searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Nhập để tìm kiếm",
                  hintStyle: TextStyle(color: Colors.grey))),
          popupShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ));
  }

  Widget _buildQualitySelection() {
    return Obx(() => DropdownSearch<PollutionQuality>.multiSelection(
          mode: Mode.MENU,
          onChanged: (item) => _controller.saveQuality(item),
          clearButtonSplashRadius: 20,
          showSelectedItems: true,
          compareFn: (item, selectedItem) => item?.key == selectedItem?.key,
          selectedItems: _controller.selectedQuality.toList(),
          showSearchBox: true,
          dropdownSearchDecoration: InputDecoration(
            labelText: "Mức độ ô nhiễm",
            hintText: "Chọn mức độ ô nhiễm",
            contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
          ),
          itemAsString: (item) => item?.name ?? "",
          onFind: (String? filter) => _controller.getPollutionQualities(),
          maxHeight: 300,
          searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Nhập để tìm kiếm",
                  hintStyle: TextStyle(color: Colors.grey))),
          popupShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ));
  }

  // Widget _buildSpecialAddressInput() {
  //   return TextFormField(
  //     keyboardType: TextInputType.emailAddress,
  //     onSaved: (newValue) => _controller.specialAddress = newValue,
  //     onChanged: (value) {
  //       _controller.specialAddress = value;
  //     },
  //     minLines: 1,
  //     maxLines: 5,
  //     decoration: InputDecoration(
  //       labelText: "Địa chỉ chi tiết",
  //       hintText: "Nhập địa chỉ chi tiết",
  //       // floatingLabelBehavior: FloatingLabelBehavior.always,
  //       contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 20),
  //       border: OutlineInputBorder(),
  //     ),
  //   );
  // }
}
