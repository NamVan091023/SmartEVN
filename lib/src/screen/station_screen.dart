import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/model/province_data.dart';

class StationData extends StatefulWidget {
  const StationData({Key? key}) : super(key: key);
  static bool IS_FIRST_TIME = true;
  @override
  _StationDataState createState() => _StationDataState();
}

class _StationDataState extends State<StationData> {
  late List<ProvinceData> provinceData;
  @override
  void initState() {
    provinceData = [];
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            'Thông tin từ trạm khoan trắc',
            style: TextStyle(color: Colors.white, fontSize: titleTextSize),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03),
          child: ListView.builder(
              itemCount: provinceData.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildRow(index);
              }),
        ));
  }

  Future<void> getData() async {
    provinceData.clear();
    Stream.fromIterable([
      'Cau Giay',
      'Dong Da',
      'Ha Dong',
      'Tay Ho',
      'Hoan Kiem',
      'Dong Anh',
    ]).listen((event) async {
      var data = null;
      //await PollutionNetwork().getAirVisualData(event);
      print("TAGGGG" + data!.data!.city!);
      provinceData.add(data);
      if (provinceData.length == 6) {
        setState(() {});
      }
    });
  }

  Widget _buildRow(int pos) {
    ProvinceData data = provinceData[pos];
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: MediaQuery.of(context).size.width * 0.32,
      decoration:
          BoxDecoration(color: outLine, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.data!.city!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "AQI: ${data.data!.current!.pollution!.aqius}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "Áp suất: ${data.data!.current!.weather!.pr}hPa",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "Tốc độ gió: ${data.data!.current!.weather!.pr}m/s",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nhiệt độ: ${data.data!.current!.weather!.tp}°C",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "Độ ẩm: ${data.data!.current!.weather!.hu}%",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
