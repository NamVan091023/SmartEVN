import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/generated/assets.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/components/aqi_weather_card.dart';
import 'package:pollution_environment/src/screen/detail_aqi/components/forescast_aqi.dart';
import 'package:pollution_environment/src/screen/home/components/pollution_aqi_items.dart';

import 'detail_aqi_controller.dart';

class DetailAQIScreen extends StatelessWidget {
  late final DetailAQIController _controller = Get.put(DetailAQIController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chất lượng không khí"),
      ),
      body: Obx(
        () => Container(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: ListView(
              children: [
                Text(
                  _controller.aqiModel.value?.data?.city?.name ?? "",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  _controller.aqiModel.value?.data?.city?.location ?? "",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 10,
                ),
                if (_controller.aqiModel.value != null)
                  AQIWeatherCard(aqi: _controller.aqiModel.value!),
                SizedBox(
                  height: 8,
                ),
                Divider(),
                if (_controller.aqiModel.value != null)
                  PollutionAqiItems(
                    aqi: _controller.aqiModel.value!,
                  ),
                SizedBox(
                  height: 8,
                ),
                Divider(),
                if (_controller.aqiModel.value != null) _buildRecommend(),
                if (_controller.aqiModel.value != null)
                  SizedBox(
                    height: 10,
                  ),
                if (_controller.aqiModel.value != null) Divider(),
                SizedBox(
                  height: 10,
                ),
                if (_controller.aqiModel.value?.data?.forecast?.daily != null)
                  ForescastAqi(
                      _controller.aqiModel.value!.data!.forecast!.daily!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommend() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Khuyến nghị",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: () {
                  _controller.recommentType.value = 0;
                  _controller.changeRecommed();
                },
                child: Card(
                  elevation: 3,
                  color: _controller.recommentType.value == 0
                      ? getQualityColor(getAQIRank(
                          (_controller.aqiModel.value?.data?.aqi ?? 0)
                              .toDouble()))
                      : null,
                  child: Container(
                    width: 100,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            Assets.healthy,
                            height: 32,
                            width: 32,
                          ),
                          Expanded(
                            child: Text(
                              "Sức khỏe",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _controller.recommentType.value = 1;
                  _controller.changeRecommed();
                },
                child: Card(
                  color: _controller.recommentType.value == 1
                      ? getQualityColor(getAQIRank(
                          (_controller.aqiModel.value?.data?.aqi ?? 0)
                              .toDouble()))
                      : null,
                  elevation: 3,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            Assets.normalPeople,
                            height: 32,
                            width: 32,
                          ),
                          Expanded(
                            child: Text(
                              "Người bình thường",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _controller.recommentType.value = 2;
                  _controller.changeRecommed();
                },
                child: Card(
                  color: _controller.recommentType.value == 2
                      ? getQualityColor(getAQIRank(
                          (_controller.aqiModel.value?.data?.aqi ?? 0)
                              .toDouble()))
                      : null,
                  elevation: 3,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            Assets.sensitivePeople,
                            height: 32,
                            width: 32,
                          ),
                          Expanded(
                            child: Text(
                              "Người nhạy cảm",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Card(
          elevation: 3,
          color: getQualityColor(getAQIRank(
              (_controller.aqiModel.value?.data?.aqi ?? 0).toDouble())),
          child: SizedBox(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                _controller.recommend.value,
                style: TextStyle(
                    color: getTextColorRank(getAQIRank(
                        (_controller.aqiModel.value?.data?.aqi ?? 0)
                            .toDouble()))),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
