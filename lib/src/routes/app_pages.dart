import 'package:get/get.dart';
import 'package:pollution_environment/src/screen/forgot_password/forgot_password_screen.dart';
import 'package:pollution_environment/src/screen/main/main_board.dart';
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
  ];
}