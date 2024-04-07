import 'package:pollution_environment/new_base/commons/app_colors.dart';
import 'package:pollution_environment/new_base/commons/app_images.dart';
import 'package:pollution_environment/new_base/commons/app_text_styles.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
<<<<<<< HEAD
              AppImages.imgBackground,
=======
              AppImages.iconLogo,
>>>>>>> origin/feature/hiep-create-base
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: true,
              top: false,
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const HomePage(),
                  //   ),
                  // );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  margin: const EdgeInsets.symmetric(horizontal: 58),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      "EXPLORE",
                      style: AppTextStyle.textSecondaryS16Bold,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
