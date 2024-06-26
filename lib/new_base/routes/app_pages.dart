import 'package:get/get.dart';
import 'package:pollution_environment/new_base/routes/router_paths.dart';

import '../../views/screen/detail_pollution/detail_pollution_screen.dart';
import '../../views/screen/edit_profile/edit_profile_screen.dart';
import '../../views/screen/filter/filter_screen.dart';
import '../../views/screen/forgot_password/forgot_password_screen.dart';
import '../../views/screen/home/favorite/favorite_screen.dart';
import '../../views/screen/main/main_board.dart';
import '../../views/screen/manage/manage_screen.dart';
import '../../views/screen/notification/main_notification_screen.dart';
import '../../views/screen/profile/other_profile/other_profile_screen.dart';
import '../../views/screen/profile/profile/profile_screen.dart';
import '../../views/screen/report/create_report.dart';
import '../../views/screen/sign_in/sign_in_screen.dart';
import '../../views/screen/sign_up/sign_up_screen.dart';
import '../../views/screen/splash/splash_screen.dart';


class AppPages {
  static final pages = [
    GetPage(
      name: RouterPaths.INITIAL,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: RouterPaths.LOGIN_SCREEN,
      page: () => const SignInScreen(),
      binding: SignInBindings(),
    ),
    GetPage(
      name: RouterPaths.SIGNUP_SCREEN,
      page: () => const SignUpScreen(),
      binding: SignUpBindings(),
    ),
    GetPage(
      name: RouterPaths.FORGOT_PASSWORD_SCREEN,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBindings(),
    ),
    GetPage(
      name: RouterPaths.HOME_SCREEN,
      page: () => const MainBoard(),
    ),
    GetPage(
      name: RouterPaths.MAP_FILTER_SCREEN,
      page: () => FilterMapScreen(),
    ),
    GetPage(
      name: RouterPaths.CREATE_REPORT_SCREEN,
      page: () => CreateReport(),
    ),
    GetPage(
      name: RouterPaths.EDIT_PROFILE_SCREEN,
      page: () => EditProfileScreen(),
    ),
    GetPage(
      name: RouterPaths.PROFILE_SCREEN,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: RouterPaths.OTHER_PROFILE_SCREEN,
      page: () => OtherProfileScreen(),
    ),
    GetPage(
      name: RouterPaths.DETAIL_POLLUTION_SCREEN,
      page: () => DetailPollutionScreen(),
    ),
    GetPage(
      name: RouterPaths.NOTIFICATION_SCREEN,
      page: () => const NotificationScreen(),
    ),
    GetPage(
      name: RouterPaths.MANAGE_SCREEN,
      page: () => const ManageScreen(),
    ),
    GetPage(
      name: RouterPaths.FAVORITE_SCREEN,
      page: () => FavoriteScreen(),
    ),
  ];
}
