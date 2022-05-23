import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/components/aqi_weather_card.dart';
import 'package:pollution_environment/src/model/favorite_model.dart';
import 'package:pollution_environment/src/routes/app_pages.dart';
import 'package:pollution_environment/src/screen/detail_aqi/detail_aqi_screen.dart';
import 'package:pollution_environment/src/screen/home/favorite/favorite_controller.dart';
import 'package:pollution_environment/src/screen/home/home_controller.dart';

class FavoriteScreen extends StatelessWidget {
  final FavoriteController _controller = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn tỉnh/thành phố"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Obx(
          () => ListView.separated(
            itemBuilder: (ctx, index) {
              return ListTile(
                title: Text(_controller.provinces.toList()[index].name ?? ""),
                onTap: () {
                  _controller
                      .saveProvince(_controller.provinces.toList()[index]);
                  Get.to(() => ChooseDistrictScreen());
                },
              );
            },
            itemCount: _controller.provinces.toList().length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          ),
        ),
      ),
    );
  }
}

class ChooseDistrictScreen extends StatelessWidget {
  final FavoriteController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn quận/huyện"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Obx(
          () => ListView.separated(
            itemBuilder: (ctx, index) {
              return ListTile(
                title: Text(_controller.districts.toList()[index].name ?? ""),
                onTap: () {
                  _controller
                      .saveDistrict(_controller.districts.toList()[index]);
                  Get.to(() => ChooseWardScreen());
                },
              );
            },
            itemCount: _controller.districts.toList().length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          ),
        ),
      ),
    );
  }
}

class ChooseWardScreen extends StatelessWidget {
  final FavoriteController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn phường/xã"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Obx(
          () => ListView.separated(
            itemBuilder: (ctx, index) {
              return ListTile(
                title: Text(_controller.wards.toList()[index].name ?? ""),
                onTap: () {
                  _controller.saveWard(_controller.wards.toList()[index]);
                  _controller.getAQI();
                  Get.to(() => AddFavoriteScreen());
                },
              );
            },
            itemCount: _controller.wards.toList().length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          ),
        ),
      ),
    );
  }
}

class AddFavoriteScreen extends StatelessWidget {
  final FavoriteController _controller = Get.find();
  final HomeController _homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm địa điểm quan tâm"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Obx(() => ListView(
              children: [
                if (_controller.aqi.value?.data != null)
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => DetailAQIScreen(),
                            arguments: _controller.aqi.value?.data?.idx);
                      },
                      child: AQIWeatherCard(aqi: _controller.aqi.value!),
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_controller.aqi.value?.data != null)
                  Container(
                    child: Align(
                      child: SizedBox(
                        width: 200,
                        child: OutlinedButton(
                          onPressed: () async {
                            Favorite favorite = Favorite(
                              province:
                                  _controller.selectedProvince.value!.name!,
                              district:
                                  _controller.selectedDistrict.value!.name!,
                              ward: _controller.selectedWard.value!.name!,
                              lat: _controller.lat.value!,
                              lng: _controller.lng.value!,
                            );

                            await Hive.openBox<Favorite>(KEY_FAVORITE);
                            Box box = Hive.box<Favorite>(KEY_FAVORITE);
                            box.add(favorite);
                            _homeController.getFavorite();
                            Get.offAllNamed(Routes.HOME_SCREEN);
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                          ),
                          child: const Text("Lưu"),
                        ),
                      ),
                    ),
                  ),
              ],
            )),
      ),
    );
  }
}
