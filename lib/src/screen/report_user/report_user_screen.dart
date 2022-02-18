import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/model/pollution_response.dart';
import 'package:pollution_environment/src/network/apis/pollution/pollution_api.dart';
import 'package:pollution_environment/src/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReportUser extends StatefulWidget {
  @override
  _ReportUserState createState() => new _ReportUserState();
}

class _ReportUserState extends State<ReportUser> with TickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();
  List<PollutionModel> pollutions = [];
  static const int _itemsPerPage = 10;
  bool canLoadMore = true;
  int nextPage = 1;

  Future<void> getData() async {
    var data = await PollutionApi()
        .getPollutionAuth(page: nextPage, limit: _itemsPerPage);
    setState(() {
      pollutions.addAll(data.results ?? []);
    });

    nextPage++;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Báo cáo của bạn',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: ClassicHeader(
            idleText: "Kéo để làm mới",
            refreshingText: "Đang tải...",
            releaseText: "Kéo để làm mới",
            completeText: "Lấy dữ liệu thành công",
            textStyle: TextStyle(fontSize: 15, color: kTextColor),
            refreshStyle: RefreshStyle.Follow,
          ),
          footer: ClassicFooter(
            idleText: "Kéo để tải thêm",
            loadingText: "Đang tải...",
            failedText: "Tải thêm dữ liệu thất bại",
            noDataText: "Không có dữ liệu mới",
            canLoadingText: "Kéo để tải thêm",
            textStyle: TextStyle(
              color: kTextColor,
              fontSize: 15,
            ),
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (c, i) => buildRow(c, i),
            itemCount: pollutions.length,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "report",
        child: new Icon(Icons.add),
        onPressed: () {
          Get.toNamed(Routes.CREATE_REPORT_SCREEN);
        },
        tooltip: "Thêm báo cáo",
      ),
    );
  }

  void doNothing(BuildContext context) {}
  Widget buildRow(BuildContext context, int index) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                flex: 2,
                onPressed: doNothing,
                backgroundColor: Color(0xFF7BC043),
                foregroundColor: Colors.white,
                icon: Icons.archive,
                label: 'Archive',
              ),
              SlidableAction(
                onPressed: doNothing,
                backgroundColor: Color(0xFF0392CF),
                foregroundColor: Colors.white,
                icon: Icons.save,
                label: 'Save',
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              // Vào màn xem chi tiết
              Get.toNamed(Routes.SIGNUP_SCREEN);
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Image.asset(
                      getAssetPollution(pollutions[index].type ?? '') ?? '',
                      height: 40,
                      width: 40,
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
                          Text(
                            "${pollutions[index].wardName}, ${pollutions[index].districtName}, ${pollutions[index].provinceName}",
                            style: Theme.of(context).textTheme.subtitle1,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            pollutions[index].status == 0
                                ? "Đang chờ phê duyệt"
                                : "Đã duyệt",
                            style: TextStyle(
                                color: pollutions[index].status == 0
                                    ? Colors.red
                                    : Colors.green,
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
        ));
  }
}
