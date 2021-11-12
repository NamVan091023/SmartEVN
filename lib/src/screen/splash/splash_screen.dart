import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/sharedPresf.dart';
import 'package:pollution_environment/src/commons/size_config.dart';
import 'package:pollution_environment/src/screen/splash/splash_controller.dart';

import 'components/body.dart';

class SplashScreen extends StatelessWidget {
  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    PreferenceUtils.init();
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
