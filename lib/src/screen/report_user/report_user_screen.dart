import 'package:flutter/material.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/model/report_response.dart';
import 'package:pollution_environment/src/network/pollutionApi.dart';
import 'package:pollution_environment/src/screen/report/create_report.dart';

class ReportUser extends StatefulWidget {
  _ReportUserState createState() => _ReportUserState();
}

class _ReportUserState extends State<ReportUser>
    with AutomaticKeepAliveClientMixin<ReportUser> {
  List<ReportData> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Danh sách điểm đã post',
          style: TextStyle(color: Colors.white, fontSize: titleTextSize),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03),
        child: (list != null && list.isNotEmpty)
            ? ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildRow(index);
                })
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        child: new Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreateReport()));
        },
      ),
    );
  }

  Future<void> getData() async {
    var data = await PollutionNetwork().getReport();
    setState(() {
      list = data.data;
    });
  }

  @override
  void initState() {
    list = new List();
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
                getIconTypePollution(list[index].type),
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
                        list[index].address == null ? "" : list[index].address,
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
                      child: Row(
                        children: [
                          Text(
                            list[index].status == 0
                                ? "Đang chờ phê duyệt"
                                : "Đã duyệt",
                            style: TextStyle(
                                color: list[index].status == 0
                                    ? Colors.red
                                    : Colors.green,
                                fontSize: 12),
                            maxLines: 1,
                            textAlign: TextAlign.left,
                          ),
                        ],
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
