import 'package:get/get.dart';
import 'package:pollution_environment/src/screen/edit_profile/edit_profile_screen.dart';
import 'package:pollution_environment/src/screen/filter/filter_screen.dart';
import 'package:pollution_environment/src/screen/forgot_password/forgot_password_screen.dart';
import 'package:pollution_environment/src/screen/main/main_board.dart';
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
      transition: Transition.cupertino,
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
    )
  ];
}
