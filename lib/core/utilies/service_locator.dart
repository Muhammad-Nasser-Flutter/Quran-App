import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_preferences.dart';



final getIt = GetIt.instance;

class ServicesLocator {
  void init() async {


    ///App Preferences
    getIt.registerLazySingleton<AppPreferences>(() => AppPreferences(getIt()));


    ///Shared Preferences
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerFactory<SharedPreferences>(() => sharedPreferences);
    //
    // /// Network info
    // getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));





  }
}