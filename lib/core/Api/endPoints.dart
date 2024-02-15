class EndPoints {
  static const String baseUrl = 'http://api.alquran.cloud/v1/';
  static const String quran = 'quran/quran-uthmani';

  static String quranPageUrl(int page){
    return "page/$page/quran-uthmani";
  }
}
