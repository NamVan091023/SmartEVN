import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/network/api_service.dart';
import 'package:pollution_environment/src/screen/manage/components/chart.dart';
import 'package:pollution_environment/src/screen/manage/components/line_chart.dart';
import 'package:pollution_environment/src/screen/manage/dashboard/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  late final DashboardControler _dashboardControler =
      Get.put(DashboardControler());
  late final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildChartList(),
            SizedBox(
              height: 10,
            ),
            _buildDot(context),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text(
                "Máy chủ",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              subtitle: Text(baseUrl),
              leading: Icon(
                Icons.computer_rounded,
                color: Theme.of(context).primaryColor,
              ),
              contentPadding: EdgeInsets.all(0),
            ),
            ListTile(
              title: Text(
                "Ứng dụng",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              subtitle: Obx(
                () => Text(
                    "${_dashboardControler.appName.value} - ${_dashboardControler.version.value} - ${_dashboardControler.buildNumber.value}"),
              ),
              leading: Icon(
                Icons.settings_applications,
                color: Theme.of(context).primaryColor,
              ),
              contentPadding: EdgeInsets.all(0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartList() {
    return CarouselSlider(
      carouselController: _carouselController,
      items: [
        Obx(() => Chart(
              air: _dashboardControler.airCnt.value,
              land: _dashboardControler.landCnt.value,
              sound: _dashboardControler.soundCnt.value,
              water: _dashboardControler.waterCnt.value,
            )),
        Obx(
          () => LineChartWeek(
            weekAirData: _dashboardControler.weekAirData.toList(),
            weekLandData: _dashboardControler.weekLandData.toList(),
            weekSoundData: _dashboardControler.weekSoundData.toList(),
            weekWaterData: _dashboardControler.weekWaterData.toList(),
          ),
        ),
      ],
      options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 0.9,
          height: 400,
          viewportFraction: 1,
          enableInfiniteScroll: false,
          initialPage: 0,
          disableCenter: true,
          onPageChanged: (index, reason) {
            _dashboardControler.currentChart.value = index;
          }),
    );
  }

  Widget _buildDot(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: ["1", "2"].asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _carouselController.animateToPage(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).primaryColor).withOpacity(
                      _dashboardControler.currentChart.value == entry.key
                          ? 1
                          : 0.2)),
            ),
          );
        }).toList(),
      ),
    );
  }
}
