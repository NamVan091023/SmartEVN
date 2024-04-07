import 'package:flutter/material.dart';
import 'package:pollution_environment/new_base/models/entities/waqi_ip_model.dart';

import 'forecast_item_day.dart';

class ForecastAqi extends StatefulWidget {
  final DailyEntity daily;

  const ForecastAqi({
    Key? key,
    required this.daily,
  }) : super(key: key);

  @override
  ForecastAqiState createState() => ForecastAqiState();
}

class ForecastAqiState extends State<ForecastAqi>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          const Text(
            "Dự báo",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 50,
            child: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Theme.of(context).primaryColor,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              indicatorColor: Theme.of(context).primaryColor,
              indicatorPadding: const EdgeInsets.all(8),
              indicatorWeight: 3,
              tabs: const [
                Tab(
                  text: "O₃",
                ),
                Tab(
                  text: "PM¹⁰",
                ),
                Tab(
                  text: "PM²⁵",
                ),
                Tab(
                  text: "UVI",
                ),
              ],
              controller: tabController,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                ForecastItemDay(
                  aqiItemDay: widget.daily.o3 ?? [],
                ),
                ForecastItemDay(
                  aqiItemDay: widget.daily.pm10 ?? [],
                ),
                ForecastItemDay(
                  aqiItemDay: widget.daily.pm25 ?? [],
                ),
                ForecastItemDay(
                  aqiItemDay: widget.daily.uvi ?? [],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
