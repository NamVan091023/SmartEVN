import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/generated/assets.dart';
import 'package:pollution_environment/src/components/aqi_weather_card.dart';
import 'package:pollution_environment/src/network/api_service.dart';
import 'package:pollution_environment/src/routes/app_pages.dart';
import 'package:pollution_environment/src/screen/detail_aqi/detail_aqi_screen.dart';
import 'package:pollution_environment/src/screen/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Environment"),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.NOTIFICATION_SCREEN);
            },
            icon: SvgPicture.asset(
              Assets.bell,
              height: 26,
              width: 26,
              color: Colors.yellow,
            ),
          ),
          if (_controller.currentUser?.value.role == ROLE_ADMIN)
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.MANAGE_SCREEN);
              },
              icon: SvgPicture.asset(
                Assets.dashboard,
                height: 30,
                width: 30,
                color: Colors.yellow,
              ),
            ),
          IconButton(
            onPressed: () => Get.toNamed(Routes.PROFILE_SCREEN),
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(10000.0),
              child: CachedNetworkImage(
                imageUrl: '$host/${_controller.currentUser?.value.avatar}',
                height: 30,
                width: 30,
                fit: BoxFit.fill,
                placeholder: (ctx, str) {
                  return Image.asset(Assets.profileAvatar);
                },
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Column(
                children: [
                  Obx(
                    () => Text(
                      _controller.currentAQI.value?.data?.city?.name ?? "",
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Obx(
                    () => Text(
                      _controller.currentAQI.value?.data?.city?.location ?? "",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              _buildAQICard(),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Align(
                  child: SizedBox(
                    width: 200,
                    child: OutlinedButton(
                      onPressed: () {
                        Get.toNamed(Routes.FAVORITE_SCREEN);
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                      ),
                      child: const Text("THÊM MỘT NƠI MỚI"),
                    ),
                  ),
                ),
              ),
              Divider(),
              favoriteWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAQICard() {
    return Obx(() => _controller.currentAQI.value != null
        ? GestureDetector(
            onTap: () {
              Get.to(() => DetailAQIScreen(),
                  arguments: _controller.currentAQI.value?.data?.idx);
            },
            child: AQIWeatherCard(aqi: _controller.currentAQI.value!),
          )
        : Container());
  }

  Widget favoriteWidget() {
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _controller.favoriteAqis.values.toList().length,
        itemBuilder: (ctx, index) {
          return ListTile(
            contentPadding: EdgeInsets.all(8),
            title: Text(_controller.favoriteAqis.keys.toList()[index]),
            subtitle: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  AQIWeatherCard(
                      aqi: _controller.favoriteAqis.values.toList()[index]),
                ]),
                Positioned(
                  right: -5,
                  child: IconButton(
                    onPressed: () {
                      _controller.removeFavorite(index);
                    },
                    icon: Container(
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(13)),
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              Get.to(() => DetailAQIScreen(),
                  arguments: _controller.favoriteAqis.values
                      .toList()[index]
                      .data
                      ?.idx);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }
}
