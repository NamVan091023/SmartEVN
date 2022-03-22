import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/components/empty_view.dart';
import 'package:pollution_environment/src/model/pollution_response.dart';
import 'package:pollution_environment/src/network/apis/pollution/pollution_api.dart';
import 'package:pollution_environment/src/routes/app_pages.dart';
import 'package:pollution_environment/src/screen/detail_pollution/detail_pollution_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReportUser extends StatefulWidget {
  @override
  _ReportUserState createState() => new _ReportUserState();
}

class _ReportUserState extends State<ReportUser>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController = RefreshController();
  List<PollutionModel> pollutions = [];
  int total = 0;
  static const int _itemsPerPage = 10;
  bool canLoadMore = true;
  int nextPage = 1;
  int? _filterSelected;

  Future<void> getData() async {
    var data = await PollutionApi().getPollutionAuth(
        page: nextPage,
        limit: _itemsPerPage,
        sortBy: "-createdAt",
        status: _filterSelected);
    setState(() {
      pollutions.addAll(data.results ?? []);
      total = data.totalResults ?? 0;
    });
    if (canLoadMore) nextPage++;
    if ((data.results ?? []).length < _itemsPerPage) {
      canLoadMore = false;
    }
  }

  Future<void> refresh() async {
    canLoadMore = true;
    pollutions.clear();
    nextPage = 1;
    await getData();
  }

  void _onRefresh() async {
    await refresh();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await getData();
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Báo cáo của bạn',
        ),
        // actions: [_buildFilter()],
      ),
      body: Padding(
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
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (c, i) {
              if (i == 0)
                return _buildFilter();
              else {
                if (pollutions.length == 0) {
                  return EmptyView();
                } else
                  return buildRow(c, i - 1);
              }
            },
            itemCount: pollutions.length == 0 ? 2 : pollutions.length + 1,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "report",
        child: new Icon(Icons.add),
        onPressed: () {
          Get.toNamed(Routes.CREATE_REPORT_SCREEN)?.then((value) => refresh());
        },
        tooltip: "Thêm báo cáo",
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
              arguments: pollutions[index].id);
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

  Widget _buildFilter() {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          FilterChip(
            label: _filterSelected == null
                ? Text("Tất cả ($total)")
                : Text("Tất cả"),
            showCheckmark: true,
            selected: _filterSelected == null,
            onSelected: (bool value) {
              setState(() {
                _filterSelected = null;
                showLoading();
                refresh().then((value) => {hideLoading()});
              });
            },
          ),
          SizedBox(
            width: 8,
          ),
          FilterChip(
            label: _filterSelected == 1
                ? Text("Đã duyệt ($total)")
                : Text("Đã duyệt"),
            showCheckmark: true,
            selected: _filterSelected == 1,
            onSelected: (bool value) {
              setState(() {
                _filterSelected = 1;
                showLoading();
                refresh().then((value) => {hideLoading()});
              });
            },
          ),
          SizedBox(
            width: 8,
          ),
          FilterChip(
            label: _filterSelected == 0
                ? Text("Đang chờ duyệt ($total)")
                : Text("Đang chờ duyệt"),
            showCheckmark: true,
            selected: _filterSelected == 0,
            onSelected: (bool value) {
              setState(() {
                _filterSelected = 0;
                showLoading();
                refresh().then((value) => {hideLoading()});
              });
            },
          ),
          SizedBox(
            width: 8,
          ),
          FilterChip(
            label: _filterSelected == 2
                ? Text("Từ chối ($total)")
                : Text("Từ chối"),
            showCheckmark: true,
            selected: _filterSelected == 2,
            onSelected: (bool value) {
              setState(() {
                _filterSelected = 2;
                showLoading();
                refresh().then((value) => {hideLoading()});
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
