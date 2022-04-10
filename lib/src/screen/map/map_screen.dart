import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/model/pollution_type_model.dart';

import 'package:pollution_environment/src/screen/filter/filter_screen.dart';
import 'package:pollution_environment/src/screen/map/map_controller.dart';

import 'components/filter_action.dart';
import 'components/view_aqi_selected.dart';
import 'components/view_pollution_selected.dart';

class MapScreen extends StatelessWidget {
  late final MapController _controller = Get.put(MapController());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _controller.getPos();
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(child: FilterMapScreen()),
      onEndDrawerChanged: (isOpen) {
        if (!isOpen) {
          _controller.getPollutionPosition();
        }
      },
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                initialCameraPosition: _controller.kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.mapController.complete(controller);
                  for (int i = 0; i < 6; i++) {
                    _controller.managers.toList()[i].setMapId(controller.mapId);
                    _controller.aqiManagers
                        .toList()[i]
                        .setMapId(controller.mapId);
                  }
                },
                onCameraMove: (position) {
                  for (int i = 0; i < 6; i++) {
                    _controller.managers.toList()[i].onCameraMove(position);
                    _controller.aqiManagers.toList()[i].onCameraMove(position);
                  }
                  _controller.getPollutionPosition();
                  _controller.getAQIMap();
                },
                onCameraIdle: () {
                  for (int i = 0; i < 6; i++) {
                    _controller.managers.toList()[i].updateMap();
                    _controller.aqiManagers.toList()[i].updateMap();
                  }
                },
                onTap: (latlng) {
                  if (_controller.pollutionSelected.value?.lat !=
                          latlng.latitude &&
                      _controller.pollutionSelected.value?.lng !=
                          latlng.longitude &&
                      _controller.aqiMarkerSelected.value?.location.latitude !=
                          latlng.latitude &&
                      _controller.aqiMarkerSelected.value?.location.longitude !=
                          latlng.longitude) {
                    _controller.animationController.forward();
                    _controller.pollutionSelected.value = null;
                  }
                },
                polygons: _controller.polygons.toSet(),
                markers: <Marker>{}
                  ..addAll(_controller.markers.toList()[0])
                  ..addAll(_controller.markers.toList()[1])
                  ..addAll(_controller.markers.toList()[2])
                  ..addAll(_controller.markers.toList()[3])
                  ..addAll(_controller.markers.toList()[4])
                  ..addAll(_controller.markers.toList()[5])
                  ..addAll(_controller.aqiMarkers.toList()[0])
                  ..addAll(_controller.aqiMarkers.toList()[1])
                  ..addAll(_controller.aqiMarkers.toList()[2])
                  ..addAll(_controller.aqiMarkers.toList()[3])
                  ..addAll(_controller.aqiMarkers.toList()[4])
                  ..addAll(_controller.aqiMarkers.toList()[5])),
          ),
          _buildSearchView(context),
          _buildFilterActionView(context),
          Obx(() => _controller.pollutionSelected.value != null
              ? _buildViewPollutionSelected(context)
              : Container()),
          Obx(() => _controller.aqiMarkerSelected.value != null
              ? _buildViewAQISelected(context)
              : Container())
        ],
      ),
    );
  }

  Widget _buildSearchView(context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, right: 5, left: 0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: ListView(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Obx(
                      () => FilterChip(
                        label: Text("Chất lượng không khí"),
                        avatar: Icon(
                          Icons.air,
                          color: Colors.blue,
                        ),
                        showCheckmark: false,
                        selected: _controller
                            .filterStorageController.isFilterAQI.value,
                        elevation: 3,
                        onSelected: (bool value) async {
                          _controller.filterStorageController.isFilterAQI
                              .value = value;

                          await _controller.getAQIMap();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Obx(() => _buildFilterChip("land")),
                    SizedBox(
                      width: 8,
                    ),
                    Obx(() => _buildFilterChip("water")),
                    SizedBox(
                      width: 8,
                    ),
                    Obx(() => _buildFilterChip("air")),
                    SizedBox(
                      width: 8,
                    ),
                    Obx(() => _buildFilterChip("sound")),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            ElevatedButton.icon(
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
              clipBehavior: Clip.antiAlias,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                minimumSize: Size(0, 0),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              icon: Icon(Icons.filter_alt_outlined),
              label: Text(
                "Lọc",
                style: TextStyle(fontSize: 13),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildViewPollutionSelected(BuildContext context) {
    if (_controller.pollutionSelected.value != null)
      _controller.animationController..reverse();
    else
      _controller.animationController..forward();
    return ViewPollutionSelected(
      offset: _controller.offset,
      pollutionSelected: _controller.pollutionSelected.value,
      currentUser: _controller.currentUser.value?.user,
    );
  }

  Widget _buildViewAQISelected(BuildContext context) {
    if (_controller.aqiMarkerSelected.value != null)
      _controller.animationController..reverse();
    else
      _controller.animationController..forward();
    return ViewAQISelected(controller: _controller);
  }

  Widget _buildFilterActionView(BuildContext context) {
    return FilterAction(controller: _controller);
  }

  Widget _buildFilterChip(String type) {
    return FilterChip(
      label: Text(getNamePollution(type)),
      avatar: Image.asset(getAssetPollution(type)),
      showCheckmark: false,
      selected: _controller.filterStorageController.selectedType
              .toList()
              .firstWhereOrNull((element) => element.key == type) !=
          null,
      elevation: _controller.filterStorageController.selectedType
                  .toList()
                  .firstWhereOrNull((element) => element.key == type) !=
              null
          ? 5
          : 0,
      onSelected: (bool value) {
        if (value) {
          _controller.filterStorageController.selectedType
              .add(PollutionType(key: type, name: getShortNamePollution(type)));
          _controller.getPollutionPosition();
        } else {
          _controller.filterStorageController.selectedType
              .removeWhere((element) => element.key == type);
          _controller.getPollutionPosition();
        }
      },
    );
  }
}
