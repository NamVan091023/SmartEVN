import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/components/default_button.dart';
import 'package:pollution_environment/src/components/drop_down.dart';
import 'package:pollution_environment/src/screen/filter/filter_screen_controller.dart';

class FilterMapScreen extends StatelessWidget {
  final FilterMapController _controller = Get.put(FilterMapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('Lọc tìm kiếm',
            style: TextStyle(color: Colors.white, fontSize: titleTextSize)),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1,
            vertical: MediaQuery.of(context).size.height * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'Thành phố:',
                  style:
                      TextStyle(fontSize: secondaryTextSize, color: mainText),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                CustomDropdown<String?>(
                  items: _controller.cities,
                  onChanged: (val) => {_controller.selectedCity = val},
                  center: true,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              children: [
                Text(
                  'Quận/ Huyện:',
                  style:
                      TextStyle(fontSize: secondaryTextSize, color: mainText),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.09,
                ),
                CustomDropdown<String?>(
                  items: _controller.districts,
                  onChanged: (val) => {_controller.selectedDistrict = val},
                  center: true,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              children: [
                Text(
                  'Loại ô nhiễm:',
                  style:
                      TextStyle(fontSize: secondaryTextSize, color: mainText),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                CustomDropdown<String>(
                  items: ['Tất cả', 'Không khí', 'Nước', 'Tiếng ồn'],
                  onChanged: (val) => {_controller.selectedPollution = val!},
                  center: true,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            DefaultButton(
              text: 'Hoàn tất',
              press: () => {
                if (_controller.selectedCity != _controller.ALL)
                  {
                    _controller.result = _controller.pollutions
                        .where((item) => item.city == _controller.selectedCity)
                        .toList()
                  },
                if (_controller.selectedDistrict != _controller.ALL)
                  {
                    _controller.result = _controller.pollutions
                        .where((item) =>
                            item.district == _controller.selectedDistrict)
                        .toList()
                  },
                if (_controller.selectedPollution != _controller.ALL)
                  {
                    _controller.result = _controller.pollutions
                        .where((item) =>
                            item.type ==
                            (_controller.selectedPollution == "Không khí"
                                ? "AIR"
                                : _controller.selectedPollution == "Nước"
                                    ? "WATER"
                                    : "NOISE"))
                        .toList()
                  },
                if (_controller.selectedCity == _controller.selectedDistrict &&
                    _controller.selectedPollution == _controller.ALL &&
                    _controller.selectedDistrict ==
                        _controller.selectedPollution)
                  {_controller.result = _controller.pollutions},
                Navigator.pop(context, _controller.result)
              },
            ),
          ],
        ),
      ),
    );
  }
}
