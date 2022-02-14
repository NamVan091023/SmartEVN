import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/sharedPresf.dart';
import 'package:pollution_environment/src/components/web_view.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/model/facebook_response.dart';
import 'package:pollution_environment/src/screen/sign_in/sign_in_screen.dart';

class ProfileNotLogin extends StatefulWidget {
  @override
  ProfileNotLoginState createState() => ProfileNotLoginState();
}

class ProfileNotLoginState extends State<ProfileNotLogin> {
  List<Data>? list;
  late DataFacebook? data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Thông tin',
            style: TextStyle(color: Colors.white, fontSize: titleTextSize),
          ),
        ),
        body: Container(
          child: (list != null && list!.isNotEmpty)
              ? ListView.builder(
                  itemCount: list!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildRow(index);
                  })
              : Container(),
        ),
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 40,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.green,
            label: Text(
              'Đăng nhập',
              style: TextStyle(color: white),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () {
              Get.to(() => SignInScreen(), binding: SignInBindings());
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  Future<void> getData() async {
    data = null;
    //await PollutionNetwork().getData();
    setState(() {
      list = data?.data;
    });
  }

  @override
  void initState() {
    list = [];
    // if (PreferenceUtils.getString("datafb") != "") {
    //   Map userMap = jsonDecode(PreferenceUtils.getString("datafb") ?? "");
    //   data = DataFacebook.fromJson(userMap as Map<String, dynamic>);
    //   list = data?.data;
    // } else
    getData();
  }

  Widget buildRow(int index) {
    double x = index != list!.length - 1 ? 5 : 70;
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: x),
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: outLine,
      ),
      child: GestureDetector(
        onTap: () {
          // launch(list[index].link, forceSafariVC: false);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyWebView(list![index].link)));
          list![index].view = list![index].view! + 1;
          String datafb = jsonEncode(data?.toJson());
          PreferenceUtils.setString("datafb", datafb);
          setState(() {});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(list![index].name!,
                  style:
                      TextStyle(color: mainText, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
            Text(
              list![index].description!,
              style: TextStyle(color: mainText, fontWeight: FontWeight.normal),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              width: double.infinity,
              child: Text(
                list![index].view.toString() + " view",
                style: TextStyle(
                    color: Colors.indigo, fontWeight: FontWeight.w600),
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
      ),
    );
  }
}
