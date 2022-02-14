import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pollution_environment/src/commons/generated/assets.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/commons/theme.dart';

import 'package:pollution_environment/src/model/internal.dart';
import 'package:pollution_environment/src/model/pollution_response.dart';
import 'package:pollution_environment/src/routes/app_pages.dart';
import 'package:pollution_environment/src/screen/filter/filter_screen.dart';
import 'package:pollution_environment/src/screen/map/map_controller.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MapScreen extends StatefulWidget {
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with AutomaticKeepAliveClientMixin<MapScreen> {
  final MapController _controller = Get.put(MapController());
  late Timer _timer;
  @override
  void initState() {
    super.initState();

    _controller.getPollutionPosition();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _controller.getPollutionPosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller.getPos();
    return Scaffold(
      body: Stack(
        children: [
          Obx(() => GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                initialCameraPosition: _controller.kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.mapController.complete(controller);
                },
                markers: _controller.markers.toSet(),
              )),
          Container(
            margin: EdgeInsets.only(top: 60, right: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 44,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(11.0))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      color: Colors.red,
                      focusColor: Colors.green,
                      icon: Icon(
                        Icons.gps_fixed_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        _controller.getPos();
                      },
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      height: 1,
                    ),
                    IconButton(
                      color: Colors.red,
                      focusColor: Colors.green,
                      icon: Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.MAP_FILTER_SCREEN);
                      },
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      height: 1,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.info_outline,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        showInfo();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
  void showInfo() {
    Alert(
        context: context,
        title: "Các loại ô nhiễm",
        // image: Image.asset("assets/icons/info.png"),
        style: alertStyle(),
        content: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: <Widget>[
                Image.asset(
                  Assets.iconPinAir,
                  height: 25,
                  width: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: new Text("Ô nhiễm không khí"),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Image.asset(
                  Assets.iconPinLand,
                  height: 25,
                  width: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: new Text("Ô nhiễm đất"),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Image.asset(
                  Assets.iconPinWater,
                  height: 25,
                  width: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: new Text("Ô nhiễm nước"),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Image.asset(
                  Assets.iconPinSound,
                  height: 25,
                  width: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: new Text("Ô nhiễm tiếng ồn"),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Mức độ ô nhiễm",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 25,
                  height: 25,
                  color: getQualityColor(6),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Tốt"),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 25,
                  height: 25,
                  color: getQualityColor(5),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Trung bình"),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 25,
                  height: 25,
                  color: getQualityColor(4),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Kém"),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 25,
                  height: 25,
                  color: getQualityColor(3),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Xấu"),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 25,
                  height: 25,
                  color: getQualityColor(2),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Rất xấu"),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 25,
                  height: 25,
                  color: getQualityColor(1),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Nguy hại"),
              ],
            ),
          ],
        ),
        buttons: []).show();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
