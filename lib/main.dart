import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pollution_environment/src/commons/background_location/location_background.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/notification_service.dart';
import 'package:pollution_environment/src/model/favorite_model.dart';
import 'package:pollution_environment/src/model/waqi/waqi_ip_model.dart';
import 'package:pollution_environment/src/network/apis/waqi/waqi.dart';
import 'package:pollution_environment/src/routes/app_pages.dart';
import 'package:pollution_environment/src/commons/theme.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:workmanager/workmanager.dart';

import 'package:home_widget/home_widget.dart';

const fetchLocationBackground = "fetchLocationBackground";
const fetchAQIBackground = "fetchAQIBackground";
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case Workmanager.iOSBackgroundTask:
        print("The iOS background fetch was triggered");
        await LocationBackground.initPlatformState();
        try {
          WAQIIpResponse aqiCurentResponse = await WaqiAPI().getAQIByIP();

          NotificationService notificationService = NotificationService();
          await notificationService.showCurrentAQI(aqiCurentResponse);
        } catch (e) {
          print(e);
        }
        break;
      case fetchAQIBackground:
        try {
          WAQIIpResponse aqiCurentResponse = await WaqiAPI().getAQIByIP();

          NotificationService notificationService = NotificationService();
          await notificationService.showCurrentAQI(aqiCurentResponse);
        } catch (e) {
          print(e);
        }
        break;
      case fetchLocationBackground:
        await LocationBackground.initPlatformState();
    }
    return Future.value(true);
  });
}

void main() async {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
  await init();
  await Hive.initFlutter();
  await Hive.openBox(HIVEBOX);
  Hive.registerAdapter(FavoriteAdapter());
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  HomeWidget.registerBackgroundCallback(backgroundCallback);
  runApp(MyApp());
}

// Called when Doing Background Work initiated from Widget
Future<void> backgroundCallback(Uri? uri) async {
  if (uri?.host == 'updatecounter') {
    int? _counter;
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
        .then((value) {
      _counter = value ?? 0;
      _counter = (_counter ?? 0) + 1;
    });
    await HomeWidget.saveWidgetData<int>('_counter', _counter);
    await HomeWidget.updateWidget(
        name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
  }
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDZUra8Uh6Bgv3VuPqQMfVsC9gUIjbGf_4",
          appId: "1:86534504753:web:ee8ddb5fc22d6f4cf3b010",
          messagingSenderId: "86534504753",
          projectId: "smartenviroment"),
    );
  } else {
    await Firebase.initializeApp();
  }

  await NotificationService().init();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    LocationBackground.initPlatformState();
    // Workmanager().cancelAll();
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );
    if (Platform.isAndroid) {
      Workmanager().registerPeriodicTask(
        fetchAQIBackground,
        fetchAQIBackground,
        frequency: Duration(minutes: 120),
      );
      Workmanager().registerPeriodicTask(
        fetchLocationBackground,
        fetchLocationBackground,
        frequency: Duration(minutes: 15),
      );
    }
  }

  @override
  void dispose() {
    // Closes all Hive boxes
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return OverlaySupport.global(
      child: DismissKeyboard(
        child: ValueListenableBuilder(
            valueListenable: Hive.box(HIVEBOX).listenable(),
            builder: (context, box, widget) {
              var themeMode = getThemeMode((box as Box).get(KEY_THEME_MODE));
              return GetMaterialApp(
                theme: themeLight(),
                darkTheme: themeDark(),
                themeMode: themeMode,
                initialRoute: Routes.INITIAL,
                getPages: AppPages.pages,
                // defaultTransition: Transition.cupertino,
                debugShowCheckedModeBanner: false,
                title: "Smart Environment",
                builder: EasyLoading.init(),
                scrollBehavior: MyCustomScrollBehavior(),
              );
            }),
      ),
    );
  }
}

class DismissKeyboard extends StatelessWidget {
  final Widget child;
  const DismissKeyboard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // xóa hiệu ứng cuộn ở các cạnh
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
