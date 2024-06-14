class SurahModel {
  int? number;
  String? name;
  int? numberOfAyahs;
  String? englishName;
  String? revelationType;

  SurahModel(
      {this.number,
        this.numberOfAyahs,
        this.name,
        this.englishName,
        this.revelationType,});

  SurahModel.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    numberOfAyahs = json['NumberOfAyahs'];
    englishName = json['englishName'];
    revelationType = json['revelationType'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['number'] = number;
    data['name'] = name;
    data['englishName'] = englishName;
    data['NumberOfAyahs'] = numberOfAyahs;
    data['revelationType'] = revelationType;
    return data;
  }
}

