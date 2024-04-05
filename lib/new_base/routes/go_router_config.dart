import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pollution_environment/new_base/routes/router_paths.dart';
import 'package:pollution_environment/new_base/ui/components/image_viewer_widget.dart';
import 'package:pollution_environment/new_base/ui/pages/aqi_detail/aqi_detail_page.dart';
import 'package:pollution_environment/views/screen/sign_in/sign_in_screen.dart';
import 'package:pollution_environment/views/screen/sign_up/sign_up_screen.dart';
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
import '../ui/pages/splash/splash_page.dart';

final goRouterConfiguration = GoRoute(
  path: RouterPaths.INITIAL,
  routes: [
    GoRoute(
      path: RouterPaths.INITIAL,
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: const SplashPage(),
      ),
    ),
    GoRoute(
      path: RouterPaths.LOGIN_SCREEN,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: RouterPaths.SIGNUP_SCREEN,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: RouterPaths.FORGOT_PASSWORD_SCREEN,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: RouterPaths.HOME_SCREEN,
      builder: (context, state) => const MainBoard(),
    ),
    GoRoute(
      path: RouterPaths.MAP_FILTER_SCREEN,
      builder: (context, state) => FilterMapScreen(),
    ),
    GoRoute(
      path: RouterPaths.CREATE_REPORT_SCREEN,
      builder: (context, state) => CreateReport(),
    ),
    GoRoute(
      path: RouterPaths.EDIT_PROFILE_SCREEN,
      builder: (context, state) => EditProfileScreen(),
    ),
    GoRoute(
      path: RouterPaths.PROFILE_SCREEN,
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      path: RouterPaths.OTHER_PROFILE_SCREEN,
      builder: (context, state) => OtherProfileScreen(),
    ),
    GoRoute(
      path: RouterPaths.DETAIL_POLLUTION_SCREEN,
      builder: (context, state) => DetailPollutionScreen(),
    ),
    GoRoute(
      path: RouterPaths.NOTIFICATION_SCREEN,
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: RouterPaths.MANAGE_SCREEN,
      builder: (context, state) => const ManageScreen(),
    ),
    GoRoute(
      path: RouterPaths.FAVORITE_SCREEN,
      builder: (context, state) => FavoriteScreen(),
    ),
    GoRoute(
      path: RouterPaths.imageViewer,
      builder: (context, state) => ImageViewerWidget(
        url: state.extra as String,
      ),
    ),
    GoRoute(
      path: RouterPaths.aqiDetailPage,
      builder: (context, state) => AqiDetailPage(
        arguments: state.extra as AqiDetailArguments,
      ),
    ),
  ],
);
