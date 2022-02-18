import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/model/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with AutomaticKeepAliveClientMixin<NotificationScreen> {
  List<Data>? list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Thông báo',
          style: TextStyle(color: Colors.white, fontSize: titleTextSize),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03),
        child: (list != null && list!.isNotEmpty)
            ? ListView.builder(
                itemCount: list!.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildRow(index);
                })
            : Container(),
      ),
    );
  }

  Future<void> getData() async {
    var data = null;
    // await PollutionNetwork().getNotification();
    setState(() {
      list = data?.data;
    });
  }

  @override
  void initState() {
    list = [];
    getData();
  }

  @override
  bool get wantKeepAlive => true;

  Widget buildRow(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFF5F6F9),
        ),
        height: MediaQuery.of(context).size.height * 0.1,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04),
          child: Row(
            children: [
              Image.asset(
                getAssetPollution("list![index].type")!,
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        list![index].address == null
                            ? ""
                            : list![index].address!,
                        style: TextStyle(color: mainText, fontSize: 17),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        list![index].range == null ? "" : list![index].range!,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
