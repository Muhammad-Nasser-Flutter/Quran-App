import 'dart:convert';
import 'dart:ui';

import 'package:adhan/adhan.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:just_audio/just_audio.dart';
import '../../../core/constant.dart';
import '../../../core/theming/assets.dart';
import '../../../core/widgets/icon_widget.dart';
import '../../../main.dart';
import 'main_layout_state.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;
class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit() : super(MainLayoutInitial());
  static MainLayoutCubit get(context) => BlocProvider.of(context);
  void changeBottomNavBar(index) {
    mainLayoutInitialScreenIndex = index;
    emit(AppBottomNavState(mainLayoutInitialScreenIndex ?? 0));
  }


}
