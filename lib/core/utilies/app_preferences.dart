import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language.dart';

const String prefsKeyLang = 'prefsKeyLang';
// const String prefsKeyToken = 'prefsKeyToken';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String language = _sharedPreferences.getString(prefsKeyLang) ??
        LanguageType.english.getValue();
    return language;
  }
  bool isEnglish() => getCurrentLanguage() == "en";
  String getCurrentLanguage() {
    // print(CacheHelper.getData( key: CacheKeys.currentLanguage,));
    return _sharedPreferences.getString(
      prefsKeyLang,
    ) ??
        "en";
  }
  Future<void> changeAppLanguage() async {
    String currentLang = await getAppLanguage();
    if (currentLang == LanguageType.arabic.getValue()) {
      /// set it to english
      _sharedPreferences.setString(
          prefsKeyLang, LanguageType.english.getValue());
    } else {
      /// set it to arabic
      _sharedPreferences.setString(
          prefsKeyLang, LanguageType.arabic.getValue());
    }
  }

  Future<Locale> getLocale() async {
    String currentLang = await getAppLanguage();
    if (currentLang == LanguageType.arabic.getValue()) {
      return arabicLocale;
    } else {
      return englishLocale;
    }
  }

  Future<void> saveBranchId(int branchId) async {
    _sharedPreferences.setInt('branchId', branchId);
  }

  Future<int> getBranchId() async {
    int branchId = _sharedPreferences.getInt('branchId') ?? 0;
    return branchId;
  }

}