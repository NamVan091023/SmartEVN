import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/size_config.dart';
import 'package:pollution_environment/src/screen/main/main_board.dart';
import 'package:pollution_environment/src/screen/splash/splash_controller.dart';

import '../../../components/default_button.dart';
// This is the best practice
import '../components/splash_content.dart';

class Body extends StatelessWidget {
  Body({Key key}) : super(key: key);
  final List<Map<String, String>> splashData = [
    {
      "text": "Chào mừng bạn cùng chúng tôi,\n Chung tay bảo vệ môi trường!",
      "image": "assets/images/image_splash1.png"
    },
    {
      "text":
          "Ô nhiễm là bắt nguồn từ việc đưa\n các chất gây ô nhiễm vào môi trường tự nhiên. ",
      "image": "assets/images/image_splash2.png"
    },
    {
      "text":
          "Ô nhiễm không khí giết chết khoảng\n 7 triệu người trên toàn thế giới mỗi năm.",
      "image": "assets/images/image_splash3.png"
    },
  ];
  final SplashController conn = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  conn.setPage(value);
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => Obx(() => buildDot(index: index)),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Tiếp tục",
                      press: () {
                        Get.to(() => MainBoard());
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: conn.currentPage.value == index ? 20 : 6,
      decoration: BoxDecoration(
        color:
            conn.currentPage.value == index ? Colors.green : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
