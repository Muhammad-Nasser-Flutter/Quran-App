import 'package:Quran/Features/Quran/Presentation/quran_listen_screen.dart';
import 'package:Quran/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../Features/Athan/Presentation/athan_screen.dart';
import '../../Features/Listen/Presentation/listen_screen.dart';
import '../../Features/Main Layout/Bloc/main_layout_cubit.dart';
import '../../Features/Main Layout/Presentation/main_layout_screen.dart';
import '../../Features/Quran/Bloc/quran_cubit.dart';
import '../../Features/Quran/Presentation/quran_read_screen.dart';
import '../../Features/Read/Presentation/read_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.homeScreen:
        return PageTransition(
          child: BlocProvider(
            create: (context) => MainLayoutCubit(),
            child: const MainLayoutScreen(),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.quranScreen:
        return PageTransition(
          child: BlocProvider(
            create: (context) => QuranCubit()..getQuranData(settings.arguments as int),
            child: const QuranReadScreen(),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.listeningScreen:
        return PageTransition(
          child: QuranListenScreen(surahIndex: settings.arguments as int,),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );

      default:
        return PageTransition(
          child: Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          settings: settings,
        );
    }
  }

  List<Widget> screens = [
    const ReadScreen(),
    const ListenScreen(),
    const AthanScreen(),
  ];
}
