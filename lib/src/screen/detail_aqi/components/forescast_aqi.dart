import 'package:flutter/material.dart';
import 'package:pollution_environment/src/model/waqi/waqi_ip_model.dart';
import 'package:pollution_environment/src/screen/detail_aqi/components/forescast_item_day.dart';

class ForescastAqi extends StatefulWidget {
  const ForescastAqi(this.daily);
  final Daily daily;
  @override
  ForescastAqiState createState() => ForescastAqiState();
}

class ForescastAqiState extends State<ForescastAqi>
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
          Text(
            "Dự báo",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 50,
            child: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              indicatorColor: Theme.of(context).primaryColor,
              indicatorPadding: EdgeInsets.all(8),
              indicatorWeight: 3,
              tabs: [
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
                ForescastItemDay(
                  aqiItemDay: widget.daily.o3 ?? [],
                ),
                ForescastItemDay(
                  aqiItemDay: widget.daily.pm10 ?? [],
                ),
                ForescastItemDay(
                  aqiItemDay: widget.daily.pm25 ?? [],
                ),
                ForescastItemDay(
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
