
import 'package:Quran/Features/Listen/Bloc/listen_cubit.dart';
import 'package:Quran/Features/Quran/Bloc/read_cubit.dart';
import 'package:Quran/core/utilies/local_notifications.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Features/Athan/bloc/athan_cubit.dart';
import 'core/Api/my_dio.dart';
import 'core/bloc_observer.dart';
import 'core/cache_helper/cache_helper.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theming/themes.dart';
import 'core/utilies/audio_init.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  MyQuranDio.init();
  Bloc.observer = MyBlocObserver();
  initAudio();
  configLoading();
  LocalNotifications.init();

  runApp(
    BlocProvider(
      create: (context) => AthanCubit()..requestPermissions(),
      child: MyApp(
        appRouter: AppRouter(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    int status = await BackgroundFetch.configure(
        BackgroundFetchConfig(
          startOnBoot: false,
          minimumFetchInterval: 720,
          stopOnTerminate: false,
          enableHeadless: true,
          requiresBatteryNotLow: false,
          forceAlarmManager: true,
          requiresCharging: false,
          requiresStorageNotLow: false,
          requiresDeviceIdle: false,
          requiredNetworkType: NetworkType.NONE,
        ), (String taskId) async {
      AthanCubit.get(context).requestPermissions();
      AthanCubit.get(context).setupTZ();

      // <-- Event handler
      // This is the fetch-event callback.
      print("[BackgroundFetch] Event received $taskId");
      // IMPORTANT:  You must signal completion of your task or the OS can punish your app
      // for taking too long in the background.
      BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      AthanCubit.get(context);
      // <-- Task timeout handler.
      // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
      print("[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
      BackgroundFetch.finish(taskId);
    });
    print('[BackgroundFetch] configure success: $status');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => ListenCubit()..initializeAllSurahs()),
          BlocProvider(create: (context) => ReadCubit()),
        ],
        child: MaterialApp(
          title: 'Quran',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          themeMode: ThemeMode.light,
          initialRoute: Routes.homeScreen,
          onGenerateRoute: widget.appRouter.generateRoute,
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
