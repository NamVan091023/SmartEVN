import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pollution_environment/src/commons/generated/assets.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:pollution_environment/src/routes/app_pages.dart';
import 'package:pollution_environment/src/screen/map/map_controller.dart';

class MapScreen extends StatelessWidget {
  final MapController _controller = Get.put(MapController());

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
          Obx(() => _buildListViewPollution()),
          _buildFilterActionView(context),
        ],
      ),
    );
  }

  Widget _buildListViewPollution() {
    return _controller.pollutions.isNotEmpty &&
            _controller.indexPollutionSelected.value != null
        ? Align(
            alignment: Alignment.bottomCenter,
            child: CarouselSlider.builder(
              carouselController: _controller.carouselController.value,
              itemCount: _controller.pollutions.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shadowColor: Colors.grey,
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            getAssetPollution(
                                _controller.pollutions[itemIndex].type!),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getNamePollution(
                                      _controller.pollutions[itemIndex].type!),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${_controller.pollutions[itemIndex].specialAddress}, ${_controller.pollutions[itemIndex].wardName}, ${_controller.pollutions[itemIndex].districtName}, ${_controller.pollutions[itemIndex].provinceName}",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  getQualityText(_controller
                                          .pollutions[itemIndex].qualityScore ??
                                      0),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                onPageChanged: (index, _) async {
                  var mapController = await _controller.mapController.future;
                  mapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        zoom: 13.0,
                        target: LatLng(_controller.pollutions[index].lat!,
                            _controller.pollutions[index].lng!),
                      ),
                    ),
                  );
                },
                initialPage: _controller.indexPollutionSelected.value ?? 0,
              ),
            ),
          )
        : Container();
  }

  Widget _buildFilterActionView(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60, right: 10),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          width: 44,
          decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
              borderRadius: new BorderRadius.all(const Radius.circular(11.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                focusColor: Colors.green,
                icon: Icon(
                  Icons.gps_fixed_outlined,
                ),
                onPressed: () {
                  _controller.getPos();
                },
              ),
              Divider(
                height: 1,
              ),
              IconButton(
                icon: Icon(
                  Icons.filter_alt_outlined,
                ),
                onPressed: () {
                  Get.toNamed(Routes.MAP_FILTER_SCREEN)
                      ?.then((value) => _controller.getPollutionPosition());
                },
              ),
              Divider(
                height: 1,
              ),
              IconButton(
                icon: Icon(
                  Icons.info_outline,
                ),
                onPressed: () {
                  showInfo();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showInfo() {
    Get.defaultDialog(
      title: "Các loại ô nhiễm",
      titleStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
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
          _buildQualityScore(6),
          SizedBox(
            height: 8,
          ),
          _buildQualityScore(5),
          SizedBox(
            height: 8,
          ),
          _buildQualityScore(4),
          SizedBox(
            height: 8,
          ),
          _buildQualityScore(3),
          SizedBox(
            height: 8,
          ),
          _buildQualityScore(2),
          SizedBox(
            height: 8,
          ),
          _buildQualityScore(1),
        ],
      ),
    );
  }

  Widget _buildQualityScore(int score) {
    return Row(
      children: <Widget>[
        Container(
          width: 25,
          height: 25,
          color: getQualityColor(score),
        ),
        SizedBox(
          width: 10,
        ),
        Text(getQualityText(score)),
      ],
    );
  }
}
