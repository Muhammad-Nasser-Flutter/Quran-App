import 'dart:io';

import 'package:Quran/Features/Listen/Bloc/listen_cubit.dart';
import 'package:Quran/Features/Quran/Bloc/read_cubit.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Features/Athan/bloc/athan_cubit.dart';
import 'core/Api/my_dio.dart';
import 'core/bloc_observer.dart';
import 'core/cache_helper/cache_helper.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theming/themes.dart';
import 'core/utilies/audio_init.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  MyQuranDio.init();
  Bloc.observer = MyBlocObserver();
  initAudio();
  configLoading();
  if(Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  // if (!(await Permission.notification.isGranted)) {
  //   await Permission.notification.request();
  // }
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(
    MyApp(
      appRouter: AppRouter(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ListenCubit()..initializeAllSurahs()),
          BlocProvider(create: (context) => ReadCubit()),
          BlocProvider(create: (context) => AthanCubit()),
        ],
        child: MaterialApp(
          title: 'Quran',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          themeMode: ThemeMode.light,
          initialRoute: Routes.homeScreen,
          onGenerateRoute: appRouter.generateRoute,
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
