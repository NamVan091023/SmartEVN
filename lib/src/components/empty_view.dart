import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pollution_environment/src/commons/generated/assets.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.iconContent,
              color: Colors.red,
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Không có dữ liệu nào")
          ],
        ),
      ),
    );
  }
}
