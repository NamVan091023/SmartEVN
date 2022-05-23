import 'package:get/get.dart';
import 'package:pollution_environment/src/screen/detail_pollution/detail_pollution_screen.dart';
import 'package:pollution_environment/src/screen/edit_profile/edit_profile_screen.dart';
import 'package:pollution_environment/src/screen/filter/filter_screen.dart';
import 'package:pollution_environment/src/screen/forgot_password/forgot_password_screen.dart';
import 'package:pollution_environment/src/screen/home/favorite/favorite_screen.dart';
import 'package:pollution_environment/src/screen/main/main_board.dart';
import 'package:pollution_environment/src/screen/manage/manage_screen.dart';
import 'package:pollution_environment/src/screen/notification/main_notification_screen.dart';
import 'package:pollution_environment/src/screen/profile/other_profile/other_profile_screen.dart';
import 'package:pollution_environment/src/screen/profile/profile/profile_screen.dart';
import 'package:pollution_environment/src/screen/report/create_report.dart';
import 'package:pollution_environment/src/screen/sign_in/sign_in_screen.dart';
import 'package:pollution_environment/src/screen/sign_up/sign_up_screen.dart';
import 'package:pollution_environment/src/screen/splash/splash_screen.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.LOGIN_SCREEN,
      page: () => SignInScreen(),
      binding: SignInBindings(),
    ),
    GetPage(
      name: Routes.SIGNUP_SCREEN,
      page: () => SignUpScreen(),
      binding: SignUpBindings(),
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD_SCREEN,
      page: () => ForgotPasswordScreen(),
      binding: ForgotPasswordBindings(),
    ),
    GetPage(
      name: Routes.HOME_SCREEN,
      page: () => MainBoard(),
    ),
    GetPage(
      name: Routes.MAP_FILTER_SCREEN,
      page: () => FilterMapScreen(),
    ),
    GetPage(
      name: Routes.CREATE_REPORT_SCREEN,
      page: () => CreateReport(),
    ),
    GetPage(
      name: Routes.EDIT_PROFILE_SCREEN,
      page: () => EditProfileScreen(),
    ),
    GetPage(
      name: Routes.PROFILE_SCREEN,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: Routes.OTHER_PROFILE_SCREEN,
      page: () => OtherProfileScreen(),
    ),
    GetPage(
      name: Routes.DETAIL_POLLUTION_SCREEN,
      page: () => DetailPollutionScreen(),
    ),
    GetPage(
      name: Routes.NOTIFICATION_SCREEN,
      page: () => NotificationScreen(),
    ),
    GetPage(
      name: Routes.MANAGE_SCREEN,
      page: () => ManageScreen(),
    ),
    GetPage(
      name: Routes.FAVORITE_SCREEN,
      page: () => FavoriteScreen(),
    ),
  ];
}
