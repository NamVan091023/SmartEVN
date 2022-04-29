import 'package:flutter/material.dart';
import 'package:pollution_environment/src/model/waqi/waqi_ip_model.dart';
import 'package:pollution_environment/src/screen/home/components/pollution_aqi_item.dart';

class PollutionAqiItems extends StatelessWidget {
  const PollutionAqiItems({
    Key? key,
    required this.aqi,
  }) : super(key: key);
  final WAQIIpResponse aqi;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Các chất thành phần",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 85,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                if (aqi.data?.iaqi?.co?.v != null)
                  PollutionAQIItem(
                    title: "Co",
                    value: aqi.data?.iaqi?.co?.v?.toString() ?? "-",
                  ),
                if (aqi.data?.iaqi?.no2?.v != null)
                  PollutionAQIItem(
                    title: "No2",
                    value: aqi.data?.iaqi?.no2?.v?.toString() ?? "-",
                  ),
                if (aqi.data?.iaqi?.o3?.v != null)
                  PollutionAQIItem(
                    title: "O3",
                    value: aqi.data?.iaqi?.o3?.v?.toString() ?? "-",
                  ),
                if (aqi.data?.iaqi?.pm10?.v != null)
                  PollutionAQIItem(
                    title: "Pm10",
                    value: aqi.data?.iaqi?.pm10?.v?.toString() ?? "-",
                  ),
                if (aqi.data?.iaqi?.pm25?.v != null)
                  PollutionAQIItem(
                    title: "Pm25",
                    value: aqi.data?.iaqi?.pm25?.v?.toString() ?? "-",
                  ),
                if (aqi.data?.iaqi?.so2?.v != null)
                  PollutionAQIItem(
                    title: "So2",
                    value: aqi.data?.iaqi?.so2?.v?.toString() ?? "-",
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
