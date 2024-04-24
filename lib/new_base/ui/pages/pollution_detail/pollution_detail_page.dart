import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pollution_environment/controllers/map_controller.dart';
import 'package:pollution_environment/new_base/commons/app_images.dart';
import 'package:pollution_environment/new_base/routes/router_paths.dart';
import 'package:pollution_environment/new_base/ui/components/aqi_weather_card.dart';
import 'package:pollution_environment/new_base/ui/pages/pollution_detail/widgets/history_chart.dart';
import 'package:pollution_environment/services/commons/constants.dart';
import 'package:pollution_environment/services/commons/helper.dart';
import 'package:pollution_environment/views/components/pollution_card.dart';
import 'package:pollution_environment/views/components/pollution_user_card.dart';
import 'package:pollution_environment/views/screen/home/components/pollution_aqi_items.dart';
import 'package:share_plus/share_plus.dart';

import 'pollution_detail_cubit.dart';

class PollutionDetailArguments {
  final String? pollutionId;

  PollutionDetailArguments({
    this.pollutionId,
  });
}

class PollutionDetailPage extends StatelessWidget {
  final PollutionDetailArguments arguments;

  const PollutionDetailPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PollutionDetailCubit();
      },
      child: PollutionDetailChildPage(
        arguments: arguments,
      ),
    );
  }
}

class PollutionDetailChildPage extends StatefulWidget {
  final PollutionDetailArguments arguments;

  const PollutionDetailChildPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<PollutionDetailChildPage> createState() =>
      _PollutionDetailChildPageState();
}

class _PollutionDetailChildPageState extends State<PollutionDetailChildPage> {
  late final PollutionDetailCubit _cubit;

  final choices = [
    {'title': 'Duyệt', 'icon': const Icon(Icons.verified_rounded)},
    {'title': 'Từ chối', 'icon': const Icon(Icons.cancel_rounded)},
    {'title': 'Xóa', 'icon': const Icon(Icons.delete_rounded)},
  ];

  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    // mapController = GoogleMapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết ô nhiễm"),
        actions: <Widget>[
          BlocBuilder<PollutionDetailCubit, PollutionDetailState>(
              builder: (context, state) {
            return (state.currentUser?.role == kRoleAdmin ||
                    (state.currentUser?.role == kRoleMod &&
                        state.currentUser?.provinceManage
                                .contains(state.pollutionInfo?.provinceId) ==
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
                        "Chất lượng không khí tại ${state.pollutionInfo?.wardName ?? ""}, ${state.pollutionInfo?.districtName ?? ""}, ${state.pollutionInfo?.provinceName ?? ""} đang ${getQualityText(state.pollutionInfo?.qualityScore)}. Xem chi tiết tại ứng dụng Smart Environment",
                      );
                    },
                    icon: const Icon(
                      Icons.share_rounded,
                    ),
                  );
          })
        ],
      ),
      body: BlocBuilder<PollutionDetailCubit, PollutionDetailState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: ListView(
              children: [
                Text(
                  state.pollutionInfo?.specialAddress ?? "",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "${state.pollutionInfo?.wardName ?? ""}, ${state.pollutionInfo?.districtName ?? ""}, ${state.pollutionInfo?.provinceName ?? ""}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(
                  height: 10,
                ),
                if (state.pollutionInfo != null)
                  PollutionCard(pollutionModel: state.pollutionInfo!),
                _buildUserCard(),
                const SizedBox(
                  height: 8,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        (state.pollutionInfo?.status == 1)
                            ? Icons.verified_rounded
                            : (state.pollutionInfo?.status == 2)
                                ? Icons.cancel_rounded
                                : Icons.timer_rounded,
                        color: (state.pollutionInfo?.status == 1)
                            ? Colors.green
                            : (state.pollutionInfo?.status == 2)
                                ? Colors.red
                                : Colors.orange,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        (state.pollutionInfo?.status == 1)
                            ? "Đã được duyệt"
                            : (state.pollutionInfo?.status == 2)
                                ? "Từ chối duyệt"
                                : "Đang chờ duyệt",
                        style: TextStyle(
                            color: (state.pollutionInfo?.status == 1)
                                ? Colors.green
                                : (state.pollutionInfo?.status == 2)
                                    ? Colors.red
                                    : Colors.orange),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (state.aqiGPS != null)
                  ExpandableNotifier(
                    child: Column(
                      children: [
                        Expandable(
                          collapsed: ExpandableButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Xem thêm chất lượng không khí",
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.blue,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                          expanded: Column(
                            children: [
                              const Divider(),
                              AQIWeatherCard(aqi: state.aqiGPS!),
                              const SizedBox(
                                height: 8,
                              ),
                              const Divider(),
                              PollutionAqiItems(aqi: state.aqiGPS!),
                              const Divider(),
                              _buildRecommend(),
                              const SizedBox(
                                height: 10,
                              ),
                              ExpandableButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Thu gọn",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_up,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          theme: const ExpandableThemeData(
                              iconColor: Colors.red,
                              animationDuration: Duration(milliseconds: 500)),
                        ),
                      ],
                    ),
                  ),
                const Divider(),
                const Text(
                  "Mô tả",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(state.pollutionInfo?.desc ?? ""),
                const SizedBox(
                  height: 8,
                ),
                if (state.pollutionInfo?.images?.isNotEmpty == true)
                  _buildImageView(state.pollutionInfo?.images ?? []),
                const SizedBox(
                  height: 8,
                ),
                HistoryChart(
                  pollutions: state.historyPollutions ?? [],
                ),
                Container(
                  
                )
                Card(
                  child: SizedBox(
                    child: GoogleMap(
                        mapType: MapType.normal,
                        myLocationEnabled: true,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: true,
                        myLocationButtonEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(state.pollutionInfo?.lat ?? 0.0,
                              state.pollutionInfo?.lng ?? 0.0),
                          zoom: 13,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          if (!(mapController.isCompleted)) {
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
                    height: 250,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageView(List<String> listImageUrl) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 3,
      ),
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        child: CachedNetworkImage(
          imageUrl: listImageUrl[index],
          placeholder: (c, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (c, e, f) => const Center(child: Icon(Icons.error)),
          fit: BoxFit.fill,
        ),
        onTap: () {
          context.push(
            RouterPaths.imageViewer,
            extra: listImageUrl[index],
          );
        },
      ),
      physics: const NeverScrollableScrollPhysics(),
      // to disable GridView's scrolling
      shrinkWrap: true,
      itemCount: listImageUrl.length,
    );
  }

  Widget _buildUserCard() {
    return BlocBuilder<PollutionDetailCubit, PollutionDetailState>(
      builder: (context, state) {
        return InkWell(
          child: PollutionUserCard(
            userModel: state.userInfo,
            createdAt: state.pollutionInfo?.createdAt,
          ),
          onTap: () {
            context.push(
              RouterPaths.OTHER_PROFILE_SCREEN,
              extra: state.userInfo?.id,
            );
            // Get.toNamed(RouterPaths.OTHER_PROFILE_SCREEN,
            //     arguments: _controller.user.value?.id,
            //     preventDuplicates: false);
          },
        );
      },
    );
  }

  Widget _buildRecommend() {
    return BlocBuilder<PollutionDetailCubit, PollutionDetailState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Khuyến nghị",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () {
                      _cubit.changeRecommend(0);
                    },
                    child: Card(
                      elevation: 3,
                      color: state.reCommentType == 0
                          ? getQualityColor(getAQIRank(
                              (state.aqiGPS?.data?.aqi ?? 0).toDouble()))
                          : null,
                      child: SizedBox(
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                AppImages.healthy,
                                height: 32,
                                width: 32,
                              ),
                              const Expanded(
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
                      _cubit.changeRecommend(1);
                    },
                    child: Card(
                      color: state.reCommentType == 1
                          ? getQualityColor(getAQIRank(
                              (state.aqiGPS?.data?.aqi ?? 0).toDouble()))
                          : null,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              AppImages.normalPeople,
                              height: 32,
                              width: 32,
                            ),
                            const Expanded(
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
                  GestureDetector(
                    onTap: () {
                      _cubit.changeRecommend(2);
                    },
                    child: Card(
                      color: state.reCommentType == 2
                          ? getQualityColor(getAQIRank(
                              (state.aqiGPS?.data?.aqi ?? 0).toDouble()))
                          : null,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              AppImages.sensitivePeople,
                              height: 32,
                              width: 32,
                            ),
                            const Expanded(
                              child: Text(
                                "Người nhạy cảm",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 3,
              color: getQualityColor(
                getAQIRank(
                  (state.aqiGPS?.data?.aqi ?? 0).toDouble(),
                ),
              ),
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    state.recommend ?? '',
                    style: TextStyle(
                      color: getTextColorRank(
                        getAQIRank(
                          (state.aqiGPS?.data?.aqi ?? 0).toDouble(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void handleClickMenu(String value) {
    switch (value) {
      case 'Duyệt':
        _cubit.changeStatus(status: 1);
        break;
      case 'Từ chối':
        _cubit.changeStatus(status: 2);
        break;
      case 'Xóa':
        _cubit.deletePollution();
        break;
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
