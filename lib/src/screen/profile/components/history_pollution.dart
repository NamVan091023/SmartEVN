import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/components/empty_view.dart';
import 'package:pollution_environment/src/model/pollution_response.dart';
import 'package:pollution_environment/src/routes/app_pages.dart';

class HistoryPollution extends StatelessWidget {
  HistoryPollution(this.pollutions);
  final List<PollutionModel> pollutions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (c, i) {
        if (pollutions.length == 0) {
          return EmptyView();
        } else
          return buildRow(c, i);
      },
      itemCount: pollutions.length == 0 ? 1 : min(10, pollutions.length),
    );
  }

  Widget buildRow(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          // Vào màn xem chi tiết
          Get.offNamed(Routes.DETAIL_POLLUTION_SCREEN,
              arguments: pollutions[index].id);
          // Get.offAllNamed(Routes.DETAIL_POLLUTION_SCREEN,
          //     arguments: pollutions[index].id);
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Image.asset(
                  getAssetPollution(pollutions[index].type),
                  width: 50,
                  height: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pollutions[index].specialAddress ?? "",
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${pollutions[index].wardName}, ${pollutions[index].districtName}, ${pollutions[index].provinceName}",
                        style: Theme.of(context).textTheme.subtitle1,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        pollutions[index].status == 0
                            ? "Đang chờ phê duyệt"
                            : (pollutions[index].status == 1
                                ? "Đã duyệt"
                                : "Từ chối duyệt"),
                        style: TextStyle(
                            color: pollutions[index].status == 0
                                ? Colors.orange
                                : pollutions[index].status == 1
                                    ? Colors.green
                                    : Colors.red,
                            fontSize: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.fontSize),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
