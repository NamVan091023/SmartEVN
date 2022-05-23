import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/components/default_button.dart';
import 'package:pollution_environment/src/model/address_model.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/apis/address/address_api.dart';
import 'package:pollution_environment/src/network/apis/alert/alert_api.dart';

class CreateAlertScreen extends StatefulWidget {
  @override
  State<CreateAlertScreen> createState() {
    return CreateAlertState();
  }
}

class CreateAlertState extends State<CreateAlertScreen> {
  String? title;
  String? content;
  List<File> images = [];
  List<ProvinceModel> provinceIds = [];
  List<ProvinceModel> provinces = [];

  UserModel? currentUser;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    currentUser = await UserStore().getAuth()?.user;
    var response = await AddressApi().getAllAddress();
    final data = response.data;
    if (currentUser?.role == ROLE_ADMIN) {
      provinces = data ?? [];
    } else {
      provinces = [];
      data?.forEach((element) {
        if ((currentUser?.provinceManage ?? []).contains(element.id)) {
          provinces.add(element);
        }
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tạo thông báo"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildFormTitle(),
                  SizedBox(
                    height: 20,
                  ),
                  _buildFormContent(),
                  SizedBox(
                    height: 20,
                  ),
                  _buildProvinceSelection(),
                  SizedBox(
                    height: 20,
                  ),
                  DottedBorder(
                    borderType: BorderType.RRect,
                    color: Theme.of(context).primaryColor,
                    strokeWidth: 2,
                    dashPattern: [5, 5],
                    radius: Radius.circular(20),
                    padding: EdgeInsets.all(6),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildImageList(context),
                          TextButton(
                              onPressed: () => loadAssets(isCamera: true),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.file_upload_rounded,
                                    size: 50,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  Text(
                                    "Tải ảnh lên",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                          TextButton(
                              onPressed: () => loadAssets(isCamera: false),
                              child: Text(
                                "Chọn ảnh từ thư viện",
                                textAlign: TextAlign.center,
                              ))
                        ],
                      ),
                    ),
                  ),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProvinceSelection() {
    return DropdownSearch<ProvinceModel>.multiSelection(
      mode: Mode.MENU,
      onChanged: (item) {
        provinceIds = item;
        setState(() {});
      },
      showSelectedItems: true,
      compareFn: (item, selectedItem) => item?.id == selectedItem?.id,
      selectedItems: provinceIds,
      showSearchBox: true,
      dropdownSearchDecoration: InputDecoration(
        labelText: "Phạm vi",
        hintText: "Chọn tỉnh/thành phố nhận thông báo",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      itemAsString: (item) => item?.name ?? "",
      items: provinces,
      maxHeight: 300,
      searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: Icon(Icons.search),
              hintText: "Nhập để tìm kiếm",
              hintStyle: TextStyle(color: Colors.grey))),
      popupShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  Widget _buildImageList(BuildContext context) {
    return images.isNotEmpty
        ? new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(5.0),
                height: 150.0,
                child: ListView.builder(
                    itemCount: images.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => _buildItemImage(index)),
              ),
              Divider(
                color: Theme.of(context).primaryColor,
              ),
            ],
          )
        : SizedBox();
  }

  Widget _buildItemImage(int index) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(1),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.file(
              images[index],
              width: 150,
              height: 150,
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                images.removeAt(index);
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(1),
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Icon(Icons.close, size: 16, color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadAssets({required bool isCamera}) async {
    List<XFile> resultList = <XFile>[];
    final ImagePicker _picker = ImagePicker();
    try {
      if (isCamera) {
        XFile? image = await _picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          images.add(File(image.path));
          setState(() {});
        }
      } else {
        resultList = await _picker.pickMultiImage() ?? [];
        images.addAll(resultList.map((e) => File(e.path)).toList());
        setState(() {});
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Widget _buildFormTitle() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (newValue) {
        setState(() {
          this.title = newValue;
        });
      },
      onChanged: (value) {
        setState(() {
          this.title = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Trường này là bắt buộc";
        }
        return null;
      },
      maxLines: 3,
      decoration: InputDecoration(
        labelText: "Tiêu đề",
        hintText: "Nhập tiêu đề",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Widget _buildFormContent() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (newValue) {
        setState(() {
          this.content = newValue;
        });
      },
      onChanged: (value) {
        setState(() {
          this.content = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Trường này là bắt buộc";
        }
        return null;
      },
      maxLines: 5,
      decoration: InputDecoration(
        labelText: "Nội dung",
        hintText: "Nhập nội dung thông báo",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Future<void> createReport() async {
    if (_formKey.currentState!.validate()) {
      AlertApi()
          .createAlert(
              title: title!,
              content: content!,
              provinceIds: provinceIds.map((e) => e.id ?? "").toList(),
              files: images.toList(),
              onSendProgress: (sent, total) {
                showLoading(
                    text: "Đang tải lên ...", progress: 1.0 * sent / total);
              })
          .then(
        (value) {
          hideLoading();
          Fluttertoast.showToast(msg: "Tạo cảnh báo thành công");
          Get.back();
        },
        onError: (e) {
          hideLoading();
        },
      );
    }
  }
}
