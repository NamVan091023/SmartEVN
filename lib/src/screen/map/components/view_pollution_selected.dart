import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/components/pollution_card.dart';
import 'package:pollution_environment/src/screen/detail_pollution/detail_pollution_screen.dart';
import 'package:share_plus/share_plus.dart';

import '../map_controller.dart';

class ViewPollutionSelected extends StatelessWidget {
  const ViewPollutionSelected({
    Key? key,
    required MapController controller,
  })  : _controller = controller,
        super(key: key);

  final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: _controller.offset,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            child: Card(
              // width: 200,
              elevation: 5,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 10,
                  right: 5,
                  left: 5),
              child: ListView(
                padding: EdgeInsets.all(5),
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: Text(
                      "${_controller.pollutionSelected.value?.wardName ?? ""}, ${_controller.pollutionSelected.value?.districtName ?? ""}, ${_controller.pollutionSelected.value?.provinceName ?? ""}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    subtitle: Text(
                      "Lúc: ${convertDate(_controller.pollutionSelected.value?.createdAt ?? "")}",
                      style: Theme.of(context).textTheme.caption,
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          Share.share(
                              "Chất lượng ${getShortNamePollution(_controller.pollutionSelected.value?.type)} tại ${_controller.pollutionSelected.value?.wardName ?? ""}, ${_controller.pollutionSelected.value?.districtName ?? ""}, ${_controller.pollutionSelected.value?.provinceName ?? ""} đang ${getQualityText(_controller.pollutionSelected.value?.qualityScore)}. Xem chi tiết tại ứng dụng Smart Environment");
                        },
                        icon: Icon(Icons.share_rounded)),
                  ),
                  _controller.pollutionSelected.value != null
                      ? PollutionCard(
                          pollutionModel: _controller.pollutionSelected.value!,
                        )
                      : Container(),
                ],
              ),
            ),
            onTap: () {
              Get.to(() => DetailPollutionScreen(),
                  arguments: _controller.pollutionSelected.value?.id);
            },
          ),
        ));
  }
}
