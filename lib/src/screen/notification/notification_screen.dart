import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/components/empty_view.dart';
import 'package:pollution_environment/src/model/notification_model.dart';
import 'package:pollution_environment/src/network/apis/notification/notification_api.dart';
import 'package:pollution_environment/src/screen/detail_pollution/detail_pollution_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationScreen extends StatefulWidget {
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with AutomaticKeepAliveClientMixin<NotificationScreen> {
  List<NotificationModel> list = [];
  RefreshController _refreshController = RefreshController();
  static const int _itemsPerPage = 10;
  bool canLoadMore = true;
  int nextPage = 1;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thông báo',
        ),
        actions: [
          IconButton(
              onPressed: () {
                _clearAll();
              },
              icon: Icon(Icons.clear_all))
        ],
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
              if (list.isEmpty)
                return EmptyView();
              else
                return buildRow(c, i);
            },
            itemCount: list.isEmpty ? 1 : list.length,
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {
    var data = await NotificationApi().getNotifications(page: nextPage);
    setState(() {
      list.addAll(data.results ?? []);
    });
    if (canLoadMore) nextPage++;
    if ((data.results ?? []).length < _itemsPerPage) {
      canLoadMore = false;
    }
  }

  Future<void> refresh() async {
    canLoadMore = true;
    list.clear();
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

  void _clearAll() async {
    showLoading();
    NotificationApi().deleteAllNotification().then((value) {
      setState(() {
        list = [];
      });
      hideLoading();
      Fluttertoast.showToast(
          msg: value.message ?? "Xóa tất cả thông báo thành công");
    });
  }

  void _deleteById(String id) {
    setState(() {
      list.removeWhere((element) => element.id == id);
    });
    NotificationApi().deleteNotificationById(id: id);
  }

  @override
  void initState() {
    super.initState();
    list = [];
    getData();
  }

  @override
  bool get wantKeepAlive => true;

  Widget buildRow(BuildContext context, int index) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          onTap: () {
            // Vào màn xem chi tiết
            Get.to(() => DetailPollutionScreen(),
                arguments: list[index].pollution?.id);
          },
          child: Slidable(
            key: UniqueKey(),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {
                _deleteById(list[index].id!);
              }),
              children: [
                SlidableAction(
                  onPressed: (ct) {
                    _deleteById(list[index].id!);
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
                      getAssetPollution(list[index].pollution?.type ?? ''),
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
                            list[index].pollution?.specialAddress ?? "",
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${list[index].pollution?.wardName}, ${list[index].pollution?.districtName}, ${list[index].pollution?.provinceName}",
                            style: Theme.of(context).textTheme.subtitle1,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              timeAgoSinceDate(
                                  dateStr: list[index].pollution!.createdAt!),
                              style: Theme.of(context).textTheme.subtitle2,
                              maxLines: 1,
                              textAlign: TextAlign.end,
                            ),
                          ),
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
