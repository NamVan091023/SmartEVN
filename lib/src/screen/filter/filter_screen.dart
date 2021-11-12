import 'package:flutter/material.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/components/default_button.dart';
import 'package:pollution_environment/src/components/drop_down.dart';
import 'package:pollution_environment/src/model/pollution_position_model.dart';

class FilterScreen extends StatefulWidget {
  List<PollutionPosition> positions;

  FilterScreen(this.positions);

  @override
  _FilterScreenState createState() => _FilterScreenState(this.positions);
}

class _FilterScreenState extends State<FilterScreen> {
  final String ALL = 'Tất cả';
  List<PollutionPosition> positions = [];
  List<PollutionPosition> result = [];
  List<String> cities = new List<String>();
  List<String> districts = new List<String>();
  String selectedCity = 'Tất cả';
  String selectedDistrict = "Tất cả";
  String selectedPollution = "Tất cả";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
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
                CustomDropdown<String>(
                  items: cities,
                  onChanged: (val) => {selectedCity = val},
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
                CustomDropdown<String>(
                  items: districts,
                  onChanged: (val) => {selectedDistrict = val},
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
                  onChanged: (val) => {selectedPollution = val},
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
                if (selectedCity != ALL)
                  {
                    result = positions
                        .where((item) => item.city == selectedCity)
                        .toList()
                  },
                if (selectedDistrict != ALL)
                  {
                    result = positions
                        .where((item) => item.district == selectedDistrict)
                        .toList()
                  },
                if (selectedPollution != ALL)
                  {
                    result = positions
                        .where((item) =>
                            item.type ==
                            (selectedPollution == "Không khí"
                                ? "AIR"
                                : selectedPollution == "Nước"
                                    ? "WATER"
                                    : "NOISE"))
                        .toList()
                  },
                if (selectedCity == selectedDistrict &&
                    selectedPollution == ALL &&
                    selectedDistrict == selectedPollution)
                  {result = positions},
                Navigator.pop(context, result)
              },
            ),
          ],
        ),
      ),
    );
  }

  _FilterScreenState(this.positions) {
    cities.add('Tất cả');
    districts.add('Tất cả');
    cities.addAll(positions.map((item) => item.city).toSet().toList());
    districts.addAll(positions.map((item) => item.district).toSet().toList());
  }
}
