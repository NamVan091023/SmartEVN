import 'package:flutter/material.dart';
import 'package:pollution_environment/src/commons/size_config.dart';

import 'home_header.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
          ],
        ),
      ),
    );
  }
}
