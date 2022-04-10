import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/components/full_image_viewer.dart';
import 'package:pollution_environment/src/components/pollution_card.dart';
import 'package:pollution_environment/src/components/pollution_user_card.dart';
import 'package:pollution_environment/src/network/api_service.dart';
import 'package:pollution_environment/src/routes/app_pages.dart';
import 'package:pollution_environment/src/screen/detail_pollution/components/history_chart.dart';
import 'package:pollution_environment/src/screen/detail_pollution/detail_pollution_controller.dart';
import 'package:share_plus/share_plus.dart';

class DetailPollutionScreen extends StatelessWidget {
  late final DetailPollutionController _controller =
      Get.put(DetailPollutionController());

  final choices = [
    {'title': 'Duyệt', 'icon': const Icon(Icons.verified_rounded)},
    {'title': 'Từ chối', 'icon': const Icon(Icons.cancel_rounded)},
    {'title': 'Xóa', 'icon': const Icon(Icons.delete_rounded)},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chi tiết ô nhiễm"), actions: <Widget>[
        Obx(() => (_controller.currentUser.value?.role == "admin" ||
                (_controller.currentUser.value?.role == "mod" &&
                    _controller.currentUser.value?.provinceManage.contains(
                            _controller.pollutionModel.value?.provinceId) ==
                        true))
            ? PopupMenuButton<String>(
                onSelected: handleClickMenu,
                itemBuilder: (BuildContext context) {
                  return choices.map((ch) {
                    return PopupMenuItem<String>(
                      value: ch['title'].toString(),
                      child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          minLeadingWidth: 0,
                          leading: ch['icon'] as Widget,
                          title: Text(
                            ch['title'].toString(),
                          )),
                    );
                  }).toList();
                },
              )
            : IconButton(
                onPressed: () {
                  Share.share(
                      "Chất lượng không khí tại ${_controller.pollutionModel.value?.wardName ?? ""}, ${_controller.pollutionModel.value?.districtName ?? ""}, ${_controller.pollutionModel.value?.provinceName ?? ""} đang ${getQualityText(_controller.pollutionModel.value?.qualityScore)}. Xem chi tiết tại ứng dụng Smart Environment");
                },
                icon: Icon(Icons.share_rounded))),
      ]),
      body: Obx(
        () => Container(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: ListView(
              children: [
                Text(
                  _controller.pollutionModel.value?.specialAddress ?? "",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "${_controller.pollutionModel.value?.wardName ?? ""}, ${_controller.pollutionModel.value?.districtName ?? ""}, ${_controller.pollutionModel.value?.provinceName ?? ""}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 10,
                ),
                _buildTypeCard(context),
                _buildUserCard(context),
                SizedBox(
                  height: 8,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        (_controller.pollutionModel.value?.status == 1)
                            ? Icons.verified_rounded
                            : (_controller.pollutionModel.value?.status == 2)
                                ? Icons.cancel_rounded
                                : Icons.timer_rounded,
                        color: (_controller.pollutionModel.value?.status == 1)
                            ? Colors.green
                            : (_controller.pollutionModel.value?.status == 2)
                                ? Colors.red
                                : Colors.orange,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        (_controller.pollutionModel.value?.status == 1)
                            ? "Đã được duyệt"
                            : (_controller.pollutionModel.value?.status == 2)
                                ? "Từ chối duyệt"
                                : "Đang chờ duyệt",
                        style: TextStyle(
                            color: (_controller.pollutionModel.value?.status ==
                                    1)
                                ? Colors.green
                                : (_controller.pollutionModel.value?.status ==
                                        2)
                                    ? Colors.red
                                    : Colors.orange),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Mô tả",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(_controller.pollutionModel.value?.desc ?? ""),
                SizedBox(
                  height: 8,
                ),
                if (_controller.pollutionModel.value?.images?.isNotEmpty ==
                    true)
                  _buildImageView(),
                SizedBox(
                  height: 8,
                ),
                Obx(
                  () => HistoryChart(
                    pollutions: _controller.historyPollutions.toList(),
                  ),
                ),
                Card(
                  child: Container(
                    child: Obx(
                      () => GoogleMap(
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: true,
                          myLocationButtonEnabled: true,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(
                                  _controller.pollutionModel.value?.lat ?? 0.0,
                                  _controller.pollutionModel.value?.lng ?? 0.0),
                              zoom: 13),
                          onMapCreated: (GoogleMapController controller) {
                            if (!_controller.mapController.isCompleted) {
                              _controller.mapController.complete(controller);
                            }
                            for (int i = 0; i < 6; i++) {
                              _controller.managers
                                  .toList()[i]
                                  .setMapId(controller.mapId);
                            }
                          },
                          onCameraMove: (position) {
                            for (int i = 0; i < 6; i++) {
                              _controller.managers
                                  .toList()[i]
                                  .onCameraMove(position);
                            }
                          },
                          onCameraIdle: () {
                            for (int i = 0; i < 6; i++) {
                              _controller.managers.toList()[i].updateMap();
                            }
                          },
                          markers: <Marker>{}
                            ..addAll(_controller.markers.toList()[0])
                            ..addAll(_controller.markers.toList()[1])
                            ..addAll(_controller.markers.toList()[2])
                            ..addAll(_controller.markers.toList()[3])
                            ..addAll(_controller.markers.toList()[4])
                            ..addAll(_controller.markers.toList()[5])),
                    ),
                    height: 250,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 3,
      ),
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        child: CachedNetworkImage(
          imageUrl: "$host/${_controller.pollutionModel.value?.images![index]}",
          placeholder: (c, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (c, e, f) => Center(child: Icon(Icons.error)),
          fit: BoxFit.fill,
        ),
        onTap: () {
          Get.to(() => FullImageViewer(
                url:
                    "$host/${_controller.pollutionModel.value?.images![index]}",
              ));
        },
      ),
      physics:
          NeverScrollableScrollPhysics(), // to disable GridView's scrolling
      shrinkWrap: true,
      itemCount: _controller.pollutionModel.value?.images?.length ?? 0,
    );
  }

  Widget _buildUserCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        child: PollutionUserCard(
          userModel: _controller.user.value,
          createdAt: _controller.pollutionModel.value?.createdAt,
        ),
        onTap: () {
          Get.toNamed(Routes.OTHER_PROFILE_SCREEN,
              arguments: _controller.user.value?.id);
        },
      ),
    );
  }

  Widget _buildTypeCard(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: _controller.pollutionModel.value != null
            ? PollutionCard(pollutionModel: _controller.pollutionModel.value!)
            : Container());
  }

  void handleClickMenu(String value) {
    switch (value) {
      case 'Duyệt':
        _controller.changeStatus(status: 1);
        break;
      case 'Từ chối':
        _controller.changeStatus(status: 2);
        break;
      case 'Xóa':
        _controller.deletePollution();
        break;
    }
  }
}
