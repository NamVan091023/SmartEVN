import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/sharedPresf.dart';
import 'package:pollution_environment/src/components/default_button.dart';
import 'package:pollution_environment/src/components/drop_down.dart';
import 'package:pollution_environment/src/model/internal.dart';
import 'package:pollution_environment/src/model/pollution_position_model.dart';

class CreateReport extends StatefulWidget {
  const CreateReport({Key? key}) : super(key: key);

  @override
  _CreateReportState createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {
  TextEditingController userNameController = new TextEditingController();
  List<Asset> images = [];
  TextEditingController addressController = TextEditingController();
  String type = "Không khí";

  @override
  Widget build(BuildContext context) {
    userNameController.text = PreferenceUtils.getString(KEY_EMAIL, "");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            'Báo cáo địa điểm ô nhiễm',
            style: TextStyle(color: Colors.white, fontSize: titleTextSize),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1),
          child: ListView(
            children: [
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: userNameController,
                enabled: false,
                decoration: InputDecoration(
                    labelText: "Người báo cáo",
                    labelStyle: TextStyle(fontSize: titleTextSize)),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    'Loại ô nhiễm:',
                    style:
                        TextStyle(fontSize: secondaryTextSize, color: mainText),
                  ),
                  Spacer(),
                  CustomDropdown<String>(
                    items: ['Không khí', 'Nước', 'Tiếng ồn'],
                    onChanged: (val) => {type = val},
                    center: true,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    'Mức độ ô nhiễm:',
                    style:
                        TextStyle(fontSize: secondaryTextSize, color: mainText),
                  ),
                  Spacer(),
                  CustomDropdown<String>(
                    items: ['Nhẹ', 'Vừa', 'Nặng'],
                    onChanged: (val) => {},
                    center: true,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Mô tả",
                    labelStyle: TextStyle(fontSize: titleTextSize)),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                    labelText: "Địa chỉ",
                    labelStyle: TextStyle(fontSize: titleTextSize)),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  images.length < 5
                      ? loadAssets()
                      : Fluttertoast.showToast(
                          msg: "Bạn chỉ được chọn tối đa 5 ảnh");
                },
                child: Container(
                  height: 40,
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: new Border.all(color: primaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: primaryColor,
                      ),
                      Spacer(),
                      Spacer(),
                      Text(
                        'Thêm ảnh',
                        style: TextStyle(color: primaryColor),
                      ),
                      Spacer(),
                      Spacer(),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              images.length > 0
                  ? Expanded(
                      child: GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: images.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 1 / 1),
                      itemBuilder: (context, index) {
                        return _buildItemImage(index);
                      },
                    ))
                  : SizedBox(),
              SizedBox(
                height: 30,
              ),
              DefaultButton(
                text: 'Hoàn thành',
                press: () => createReport(),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }

  Widget _buildItemImage(int index) {
    return Container(
      padding: EdgeInsets.all(1),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: AssetThumb(
              asset: images[index],
              width: 500,
              height: 500,
              spinner: Center(
                child: SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                setState(() {
                  images.removeAt(index);
                });
              },
              child: Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(color: white, shape: BoxShape.circle),
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: Color(0xFFFF8D00),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#FF4CAF50",
          actionBarTitle: "Pollution Environment",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#FF4CAF50",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  Future<void> createReport() async {
    showLoading();
    var query = addressController.text;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    type = type == "Không khí"
        ? "Noise"
        : type == "Nước"
            ? "WATER"
            : "AIR";
    var random = Random();
    Internal().listPosition.add(new PollutionPosition(
        id: "${random.nextInt(10000)}",
        longitude: first.coordinates.longitude.toString(),
        latitude: first.coordinates.latitude.toString(),
        type: type,
        city: "",
        district: ""));
    Internal().eventBus.fire(PollutionPosition);
    hideLoading();
    Fluttertoast.showToast(
        msg: "Tạo báo cáo thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.green,
        backgroundColor: Colors.transparent,
        fontSize: 16.0);
    Navigator.pop(context);
  }
}
