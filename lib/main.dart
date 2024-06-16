import 'package:Quran/Features/Listen/Bloc/listen_cubit.dart';
import 'package:Quran/Features/Quran/Bloc/read_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/Api/my_dio.dart';
import 'core/bloc_observer.dart';
import 'core/cache_helper/cache_helper.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theming/themes.dart';
import 'core/utilies/audio_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  MyQuranDio.init();
  Bloc.observer = MyBlocObserver();
  initAudio();
  configLoading();

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
