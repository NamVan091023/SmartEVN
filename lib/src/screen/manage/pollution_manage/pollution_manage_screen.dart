import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/components/empty_view.dart';
import 'package:pollution_environment/src/screen/detail_pollution/detail_pollution_screen.dart';
import 'package:pollution_environment/src/screen/manage/pollution_manage/pollution_manage_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PollutionManageScreen extends StatelessWidget {
  late final PollutionManageController _controller =
      Get.put(PollutionManageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: ClassicHeader(
            idleText: "Kéo để làm mới",
            refreshingText: "Đang tải...",
            releaseText: "Kéo để làm mới",
            completeText: "Lấy dữ liệu thành công",
            refreshStyle: RefreshStyle.Follow,
          ),
          footer: ClassicFooter(
            idleText: "Kéo để tải thêm",
            loadingText: "Đang tải...",
            failedText: "Tải thêm dữ liệu thất bại",
            noDataText: "Không có dữ liệu mới",
            canLoadingText: "Kéo để tải thêm",
          ),
          controller: _controller.refreshController.value,
          onRefresh: _controller.onRefresh,
          onLoading: _controller.onLoading,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _controller.textEditController.value,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search_rounded),
                    hintText: "Nhập để tìm kiếm",
                    contentPadding: EdgeInsets.all(5),
                  ),
                  onChanged: (value) async {
                    _controller.onSearch(value);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(() => (_controller.isShowFilter.value)
                    ? _buildFilter()
                    : Container()),
                Obx(
                  () => _controller.pollutionList.toList().isEmpty
                      ? EmptyView()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: buildRow,
                          itemCount: _controller.pollutionList.toList().length,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRow(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          // Vào màn xem chi tiết
          Get.to(() => DetailPollutionScreen(),
                  arguments: _controller.pollutionList[index].id)
              ?.then((value) {
            if (value == "deleted") {
              _controller.pollutionList.removeAt(index);
              _controller.total.value -= 1;
            } else {
              _controller.refresh();
            }
          });
        },
        child: Slidable(
          key: UniqueKey(),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {
              _controller.deletePollution(
                  id: _controller.pollutionList[index].id!);
            }),
            children: [
              SlidableAction(
                onPressed: (ct) {
                  _controller.deletePollution(
                      id: _controller.pollutionList[index].id!);
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Xóa',
              ),
            ],
          ),
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
                    getAssetPollution(_controller.pollutionList[index].type),
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
                          _controller.pollutionList[index].specialAddress ?? "",
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${_controller.pollutionList[index].wardName}, ${_controller.pollutionList[index].districtName}, ${_controller.pollutionList[index].provinceName}",
                          style: Theme.of(context).textTheme.subtitle1,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          _controller.pollutionList[index].status == 0
                              ? "Đang chờ phê duyệt"
                              : (_controller.pollutionList[index].status == 1
                                  ? "Đã duyệt"
                                  : "Từ chối duyệt"),
                          style: TextStyle(
                              color: _controller.pollutionList[index].status ==
                                      0
                                  ? Colors.orange
                                  : _controller.pollutionList[index].status == 1
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
      ),
    );
  }

  Widget _buildFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Trạng thái",
        ),
        Container(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 8),
                child: Obx(
                  () => FilterChip(
                      label: _controller.filterSelected.value ==
                              _controller.listFilterStatusValue[index]
                          ? Text(
                              "${_controller.listFilterStatusTxt[index]} (${_controller.total.value})")
                          : Text(_controller.listFilterStatusTxt[index]),
                      selected: _controller.filterSelected.value ==
                          _controller.listFilterStatusValue[index],
                      onSelected: (value) {
                        _controller.filterSelected.value =
                            _controller.listFilterStatusValue[index];
                        showLoading();
                        _controller.refresh().then((value) => {hideLoading()});
                      }),
                ),
              );
            },
            itemCount: _controller.listFilterStatusTxt.length,
          ),
        ),
        Text(
          "Loại ô nhiễm",
        ),
        Container(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 8),
                child: Obx(
                  () => FilterChip(
                      label: Text(getNamePollution(
                          _controller.listPollutionType[index])),
                      selected: _controller.filterTypes
                          .contains(_controller.listPollutionType[index]),
                      onSelected: (selected) {
                        if (selected)
                          _controller.filterTypes
                              .add(_controller.listPollutionType[index]);
                        else
                          _controller.filterTypes.removeWhere((element) =>
                              element == _controller.listPollutionType[index]);
                        showLoading();
                        _controller.refresh().then((value) => {hideLoading()});
                      }),
                ),
              );
            },
            itemCount: _controller.listFilterStatusTxt.length,
          ),
        ),
      ],
    );
  }
}