import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/components/empty_view.dart';
import 'package:pollution_environment/src/screen/news/iqair/iqair_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../components/iqair_cell.dart';

class IQAirScreen extends StatelessWidget {
  final IQAirController _controller = Get.put(IQAirController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: ClassicHeader(
            idleText: "Kéo để làm mới",
            refreshingText: "Đang tải...",
            releaseText: "Kéo để làm mới",
            completeText: "Lấy dữ liệu thành công",
            refreshStyle: RefreshStyle.Follow,
          ),
          controller: _controller.refreshController.value,
          onRefresh: _controller.onRefresh,
          child: Obx(
            () => _controller.areaForests.toList().isEmpty
                ? EmptyView()
                : ListView.builder(
                    itemBuilder: (ctx, index) {
                      return IQAirCell(
                        areaForestModel:
                            _controller.areaForests.toList()[index],
                        onTap: () {},
                      );
                    },
                    itemCount: _controller.areaForests.toList().length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
          ),
        ),
      ),
    );
  }
}
