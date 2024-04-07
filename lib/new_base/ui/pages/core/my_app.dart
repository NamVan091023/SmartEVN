import 'package:pollution_environment/new_base/blocs/app_cubit.dart';
import 'package:pollution_environment/new_base/configs/global_data.dart';
import 'package:pollution_environment/new_base/network/api_client.dart';
<<<<<<< HEAD
import 'package:pollution_environment/new_base/network/manager_api.dart';
import 'package:pollution_environment/new_base/reponsitories/user_repository.dart';
=======
import 'package:pollution_environment/new_base/network/aqi_client.dart';
import 'package:pollution_environment/new_base/network/manager_api.dart';
import 'package:pollution_environment/new_base/repositories/aqi_repository.dart';
import 'package:pollution_environment/new_base/repositories/user_repository.dart';
>>>>>>> origin/feature/hiep-create-base
import 'package:pollution_environment/new_base/ui/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLifecycleState state;
  late ApiClient _apiClient;
<<<<<<< HEAD
=======
  late AqiClient _aqiClient;
>>>>>>> origin/feature/hiep-create-base

  @override
  void initState() {
    _apiClient = ManagerApi.instance.apiClient;
<<<<<<< HEAD
=======
    _aqiClient = ManagerApi.instance.aqiClient;
>>>>>>> origin/feature/hiep-create-base
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IUserRepository>(create: (context) {
          return UserRepository(_apiClient);
        }),
<<<<<<< HEAD
=======
        RepositoryProvider<AqiRepository>(create: (context) {
          return AqiRepositoryImpl(_aqiClient);
        }),
>>>>>>> origin/feature/hiep-create-base
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => context.read<AppCubit>(),
            )
          ],
          child: MaterialApp(
            title: 'Demo App',
            navigatorKey: GlobalData.instance.navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              primarySwatch: Colors.blue,
              primaryColor: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: const SplashPage(),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    this.state = state;
  }
}
