import 'package:flutter/material.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/components/default_button.dart';
import 'package:pollution_environment/src/components/drop_down.dart';
import 'package:pollution_environment/src/model/all_polltion.dart';

class FilterAllScreen extends StatefulWidget {
  List<PollutionData> positions;

  FilterAllScreen(this.positions);

  @override
  _FilterAllScreenState createState() => _FilterAllScreenState(this.positions);
}

class _FilterAllScreenState extends State<FilterAllScreen> {
  final String ALL = 'Tất cả';
  List<PollutionData> positions = [];
  List<Items> positionsData = [];
  List<Items> result = [];
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
                if (selectedDistrict != ALL)
                  {
                    result = positionsData
                        .where((item) =>
                            listItemNameDistrict[item.district] ==
                            selectedDistrict)
                        .toList()
                  },
                if (selectedPollution != ALL)
                  {
                    result = positionsData
                        .where((item) =>
                            item.type ==
                            (selectedPollution == "Không khí"
                                ? 1
                                : selectedPollution == "Nước"
                                    ? 2
                                    : 3))
                        .toList()
                  },
                Navigator.pop(context, result)
              },
            ),
          ],
        ),
      ),
    );
  }

  _FilterAllScreenState(this.positions) {
    cities.add('Hà nội');
    districts.add('Tất cả');
    for (PollutionData poi in positions) {
      if (poi.items != null) {
        positionsData.addAll(poi.items);
      }
    }
    districts.addAll(positions.map((item) => item.name).toSet().toList());
  }
}
