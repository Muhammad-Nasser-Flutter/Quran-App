import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'colors.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: false, // 👈 This disables Material 3
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    backgroundColor: AppColors.scaffoldBackground,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white,
  ),
  scaffoldBackgroundColor: AppColors.scaffoldBackground,
  primaryColor: AppColors.primaryColor,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor).copyWith(surface: Colors.white),
);

// final ThemeData darkTheme = ThemeData(
//   appBarTheme: const AppBarTheme(
//     centerTitle: true,
//     systemOverlayStyle: SystemUiOverlayStyle.light,
//     elevation: 0,
//     scrolledUnderElevation: 0,
//     color: AppColors.scaffoldBackground,
//     iconTheme: IconThemeData(
//       color: Colors.white,
//     ),
//     actionsIconTheme: IconThemeData(
//       color: Colors.white,
//     ),
//   ),
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     backgroundColor: const Color(0xff10151C),
//     selectedItemColor: Colors.white,
//     unselectedItemColor: Colors.grey[600],
//   ),
//   scaffoldBackgroundColor: AppColors.scaffoldBackground,
//   primaryColor: const Color(0xff10151C),
//   colorScheme:
//       ColorScheme.fromSwatch().copyWith(background: const Color(0xff10151C)),
// );

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.white
    ..indicatorSize = 35.0
    ..radius = 10.0
    ..userInteractions = false
    ..dismissOnTap = false
    ..indicatorColor = AppColors.primaryColor
    ..maskColor = AppColors.primaryColor
    ..progressColor = AppColors.primaryColor
    ..textColor = AppColors.primaryColor // Set text color to primary
    ..boxShadow = [
      BoxShadow(
        color: AppColors.primaryColor.withOpacity(0.8), // Shadow with primary color
        spreadRadius: -1,
        blurRadius: 5,
      ),
    ];
}
