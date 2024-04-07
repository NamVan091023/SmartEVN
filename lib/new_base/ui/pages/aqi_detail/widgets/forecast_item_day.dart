import 'package:flutter/material.dart';
import 'package:pollution_environment/new_base/models/entities/waqi_ip_model.dart';

import '../../../../../services/commons/helper.dart';
import 'forecast_item.dart';

class ForecastItemDay extends StatelessWidget {
  final List<DailyAqiItem> aqiItemDay;

  const ForecastItemDay({
    Key? key,
    required this.aqiItemDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: aqiItemDay.length + 1,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return const ForecastItem(
                title: "Ngày",
                avg: 'Trung bình',
                min: 'Nhỏ nhất',
                max: 'Lớn nhất',
              );
            } else {
              return ForecastItem(
                title: convertDateFormat(
                        aqiItemDay[index - 1].day ?? "", "dd/MM") ??
                    "",
                avg: aqiItemDay[index - 1].avg.toString(),
                min: aqiItemDay[index - 1].min.toString(),
                max: aqiItemDay[index - 1].max.toString(),
              );
            }
          },

        ),
      ),
    );
  }
}
