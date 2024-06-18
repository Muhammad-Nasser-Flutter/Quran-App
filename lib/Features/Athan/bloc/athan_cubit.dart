import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:Quran/Features/Athan/bloc/athan_states.dart';
import 'package:adhan/adhan.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;
import '../../../main.dart';

class AthanCubit extends Cubit<AthanStates> {
  AthanCubit() : super(AthanInitialState());
  static AthanCubit get(context) => BlocProvider.of(context);

  Future<void> requestPermissions() async {
    // Request notification permissions
    if (!(await Permission.notification.isGranted)) {
      await Permission.notification.request();
    }

    // You can also request other permissions as needed
  }

  void setupTZ() async {
    try {
      try {
        final byteData =
            await rootBundle.load('assets/timezone/latest_all.tzf');
        tz.initializeDatabase(byteData.buffer.asUint8List());
      } catch (e) {
        print('Error loading timezone database: $e');
      }

      final prayerTimes =
      await getPrayerTimesFromApi();
      schedulePrayerNotifications(prayerTimes);

    } catch (e) {
      print(e.toString());
    }
  }

  List<Map<String, dynamic>> prayers = [];
  Future<dynamic> getPrayerTimesFromApi() async {
    prayers = [];
    emit(GetPrayersLoadingState());
    LocationPermission permission = await Geolocator.checkPermission();
    if (!(await Permission.location.isGranted)) {
       permission= await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      emit(GetPrayersErrorState());
      return;
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final url =
          'http://api.aladhan.com/v1/calendar/${DateTime.now().year}/${DateTime.now().month}?latitude=${position.latitude}&longitude=${position.longitude}&method=4';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'OK') {
          print(data["data"][DateTime.now().day - 1]["timings"]);
          data["data"][DateTime.now().day - 1]["timings"].forEach((key, value) {
            prayers.add({
              "key": key,
              "value": value,
            });
          });
          emit(GetPrayersSuccessState());
          return data["data"][DateTime.now().day - 1]["timings"];
        } else {
          emit(GetPrayersErrorState());
          throw Exception('Failed to get timezone data: ${data['status']}');
        }
      } else {
        emit(GetPrayersErrorState());
        throw Exception('Failed to fetch timezone data from API');
      }
    }
  }

  Future<PrayerTimes> getPrayerTimes() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final coordinates = Coordinates(position.latitude, position.longitude);

    final params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.hanafi;

    final prayerTimes = PrayerTimes.today(
      coordinates,
      params,
    );
    return prayerTimes;
  }

  Future<void> schedulePrayerNotifications(
      Map<String, dynamic> prayerTimes) async {
    await flutterLocalNotificationsPlugin.cancelAll();
    List<ActiveNotification> activeNotifications =
        await flutterLocalNotificationsPlugin.getActiveNotifications();
    List<PendingNotificationRequest> pendingNotifications =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    print("active: ${activeNotifications.length}");
    print("pending: ${pendingNotifications.length}");
    await scheduleNotification(
        DateTime.parse(
            "${DateTime.now().year}-${DateTime.now().month > 9 ? DateTime.now().month.toString() : "0${DateTime.now().month}"}-${DateTime.now().day > 9 ? DateTime.now().day.toString() : "0${DateTime.now().day}"} ${prayerTimes['Fajr'].toString().split(" ")[0]}"),
        'Fajr Prayer',
        0);
    await scheduleNotification(
        DateTime.parse(
            "${DateTime.now().year}-${DateTime.now().month > 9 ? DateTime.now().month.toString() : "0${DateTime.now().month}"}-${DateTime.now().day > 9 ? DateTime.now().day.toString() : "0${DateTime.now().day}"} ${prayerTimes['Dhuhr'].toString().split(" ")[0]}"),
        'Dhuhr Prayer',
        1);
    await scheduleNotification(
        DateTime.parse(
            "${DateTime.now().year}-${DateTime.now().month > 9 ? DateTime.now().month.toString() : "0${DateTime.now().month}"}-${DateTime.now().day > 9 ? DateTime.now().day.toString() : "0${DateTime.now().day}"} ${prayerTimes['Asr'].toString().split(" ")[0]}"),
        'Asr Prayer',
        2);
    await scheduleNotification(
        DateTime.parse(
            "${DateTime.now().year}-${DateTime.now().month > 9 ? DateTime.now().month.toString() : "0${DateTime.now().month}"}-${DateTime.now().day > 9 ? DateTime.now().day.toString() : "0${DateTime.now().day}"} ${prayerTimes['Maghrib'].toString().split(" ")[0]}"),
        'Maghrib Prayer',
        3);
    await scheduleNotification(
        DateTime.parse(
            "${DateTime.now().year}-${DateTime.now().month > 9 ? DateTime.now().month.toString() : "0${DateTime.now().month}"}-${DateTime.now().day > 9 ? DateTime.now().day.toString() : "0${DateTime.now().day}"} ${prayerTimes['Isha'].toString().split(" ")[0]}"),
        'Isha Prayer',
        4);
    activeNotifications =
        await flutterLocalNotificationsPlugin.getActiveNotifications();
    pendingNotifications =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    print("active: ${activeNotifications.length}");
    print("pending: ${pendingNotifications.length}");
  }

  Future<void> scheduleNotification(
      DateTime prayerTime, String prayerName, int id) async {
    var iosDetails = const DarwinNotificationDetails(
        presentSound: true,
        presentAlert: true,
        presentBadge: true,
        sound: "athan");

    print("$prayerName=>$prayerTime");
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'prayer_channel_id',
      "Prayer Time",
      channelDescription: "Notification for prayer",
      sound: RawResourceAndroidNotificationSound('athan'),
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosDetails);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      '$prayerName Prayer',
      'It is time for $prayerName prayer',
      tz.TZDateTime.from(prayerTime, tz.local),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }


  void playAthan() async {
    final player = AudioPlayer();
    await player.setAsset(
        'assets/audio/athan.mp3'); // Ensure you have an Athan audio file in your assets
  }
}
