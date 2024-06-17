import 'dart:convert';
import 'dart:io';

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
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      } else {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        // final coordinates = Coordinates(position.latitude, position.longitude);

        final timeZone = await getTimeZoneFromCoordinates(
            position.latitude, position.longitude);
        print(timeZone);
        tz.setLocalLocation(tz.getLocation(timeZone));
        // await tz.initializeTimeZone();
        final prayerTimes = await getPrayerTimes();
        print("before");
        schedulePrayerNotifications(prayerTimes);
        print("after");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getTimeZoneFromCoordinates(
      double latitude, double longitude) async {
    const apiKey =
        'AIzaSyCwoW1vvrt1JgL7Y_iOmt-xFR8el2soduY'; // Replace with your actual API key
    final url =
        'https://maps.googleapis.com/maps/api/timezone/json?location=$latitude,$longitude&timestamp=${DateTime.now().millisecondsSinceEpoch ~/ 1000}&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return data['timeZoneId'];
      } else {
        throw Exception('Failed to get timezone data: ${data['status']}');
      }
    } else {
      throw Exception('Failed to fetch timezone data from API');
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
      utcOffset: DateTime.now().timeZoneOffset,
    );
    return prayerTimes;
  }

  Future<void> schedulePrayerNotifications(PrayerTimes prayerTimes) async {
    await scheduleNotification(prayerTimes.fajr, 'Fajr Prayer', 0);
    await scheduleNotification(prayerTimes.dhuhr, 'Dhuhr Prayer', 1);
    await scheduleNotification(prayerTimes.asr, 'Asr Prayer', 2);
    await scheduleNotification(prayerTimes.maghrib, 'Maghrib Prayer', 3);
    await scheduleNotification(prayerTimes.isha, 'Isha Prayer', 4);
  }

  Future<void> scheduleNotification(
      DateTime prayerTime, String prayerName, int id) async {
    if (Platform.isAndroid) {
      await AndroidAlarmManager.oneShotAt(
        DateTime(prayerTime.year, prayerTime.month, prayerTime.day, prayerTime.hour, prayerTime.minute),
        id,
        callback,
        exact: true,
        wakeup: true,
        alarmClock: true,
      );
    } else {
      BackgroundFetch.configure(
          BackgroundFetchConfig(
            minimumFetchInterval: 15, // Minimum fetch interval in minutes
            stopOnTerminate: false,
            enableHeadless: true,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
          ), (String taskId) async {
        // Handle background fetch events
        print('[BackgroundFetch] Task $taskId executed.');

        // Perform your background task here
        // Make network requests, fetch data, etc.

        // Complete the background task
        BackgroundFetch.finish(taskId);
      }).then((int status) {
        print('[BackgroundFetch] configure success: $status');
      }).catchError((e) {
        print('[BackgroundFetch] configure error: $e');
      });
    }
  }

  void callback() {
    _showNotification('Prayer Time', 'It is time for prayer');
    playAthan();
  }

  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'prayer_channel_id',
      'Prayer Notifications',
      channelDescription: 'Notifications for prayer times',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);
  }

  void playAthan() async {
    final player = AudioPlayer();
    await player.setAsset(
        'assets/audio/athan.mp3'); // Ensure you have an Athan audio file in your assets
  }
}
