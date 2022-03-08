import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/commons/sharedPresf.dart';
import 'package:pollution_environment/src/components/full_image_viewer.dart';
import 'package:pollution_environment/src/components/username.dart';
import 'package:pollution_environment/src/network/api_service.dart';
import 'package:pollution_environment/src/screen/detail_pollution/detail_pollution_controller.dart';

class DetailPollutionScreen extends StatelessWidget {
  late final DetailPollutionController _controller =
      Get.put(DetailPollutionController());

  final choices = [
    {'title': 'Duyệt', 'icon': const Icon(Icons.verified_rounded)},
    {'title': 'Từ chối', 'icon': const Icon(Icons.cancel_rounded)},
    {'title': 'Xóa', 'icon': const Icon(Icons.delete_rounded)},
    {'title': 'Chỉnh sửa', 'icon': const Icon(Icons.edit)},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết ô nhiễm"),
        actions: <Widget>[
          if (PreferenceUtils.getBool(KEY_IS_ADMIN))
            PopupMenuButton<String>(
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
            ),
        ],
      ),
      body: Obx(
        () => Container(
          child: Padding(
            padding: EdgeInsets.all(10),
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
      itemCount: _controller.pollutionModel.value?.images?.length,
    );
  }

  Widget _buildUserCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10000.0),
                child: CachedNetworkImage(
                  imageUrl: "$host/${_controller.user.value?.avatar}",
                  placeholder: (c, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (c, e, f) => Center(
                      child: Icon(
                    Icons.person,
                    size: 50,
                  )),
                  fit: BoxFit.fill,
                  width: 50,
                  height: 50,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dữ liệu được cung cấp bởi",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Obx(
                      () => Row(
                        children: [
                          if (_controller.user.value != null)
                            UserName(user: _controller.user.value!),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Lúc: ${convertDate(_controller.pollutionModel.value?.createdAt ?? "")}",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Card(
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            height: 100,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Image.asset(getAssetPollution(
                        _controller.pollutionModel.value?.type)),
                    color: getQualityColor(
                        _controller.pollutionModel.value?.qualityScore),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [
                          0.1,
                          0.4,
                          0.6,
                          0.9,
                        ],
                        colors: [
                          getQualityColor(_controller
                                  .pollutionModel.value?.qualityScore)
                              .withAlpha(220),
                          getQualityColor(_controller
                                  .pollutionModel.value?.qualityScore)
                              .withAlpha(170),
                          getQualityColor(_controller
                                  .pollutionModel.value?.qualityScore)
                              .withAlpha(250),
                          getQualityColor(_controller
                                  .pollutionModel.value?.qualityScore)
                              .withAlpha(100),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Chất lượng",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          getQualityText(
                              _controller.pollutionModel.value?.qualityScore),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(5),
        ),
      ),
    );
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
      case 'Chỉnh sửa':
        break;
    }
  }
}
