class AyahModel {
  int? numberInSurah;
  int? surahNumber;
  String? name;
  int? numberInPage;
  String? translationInEnglish;
  String? revelationType;

  AyahModel(
      {this.numberInSurah,
        this.numberInPage,
        this.surahNumber,
        this.name,
        this.translationInEnglish,
        this.revelationType,});

  AyahModel.fromJson(Map<String, dynamic> json) {
    numberInSurah = json['numberInSurah'];
    name = json['name'];
    numberInPage = json['numberInPage'];
    translationInEnglish = json['translationInEnglish'];
    revelationType = json['revelationType'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['numberInSurah'] = numberInSurah;
    data['name'] = name;
    data['englishName'] = translationInEnglish;
    data['NumberOfAyahs'] = numberInPage;
    data['revelationType'] = revelationType;
    return data;
  }
}

