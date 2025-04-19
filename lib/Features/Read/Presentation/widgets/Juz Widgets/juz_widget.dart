import 'package:Quran/core/helpers/extensions.dart';
import 'package:Quran/core/routing/routes.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/separator.dart';
import 'juz_item_widget.dart';

class JuzWidget extends StatelessWidget {
  const JuzWidget({super.key});

  Map<String,dynamic> getJuzData(int juzNumber) {
    switch(juzNumber) {
      case 1:
        return {
          "nameAr":"الجزء ١",
          "nameEng":"Juz 1",
          "number":1
        };

      case 2:
        return {
          "nameAr":"الجزء ٢",
          "nameEng":"Juz 2",
          "number":2
        };

      case 3:
        return {
          "nameAr":"الجزء ٣",
          "nameEng":"Juz 3",
          "number":3
        };

      case 4:
        return {
          "nameAr":"الجزء ٤",
          "nameEng":"Juz 4",
          "number":4
        };

      case 5:
        return {
          "nameAr":"الجزء ٥",
          "nameEng":"Juz 5",
          "number":5
        };

      case 6:
        return {
          "nameAr":"الجزء ٦",
          "nameEng":"Juz 6",
          "number":6
        };

      case 7:
        return {
          "nameAr":"الجزء ٧",
          "nameEng":"Juz 7",
          "number":7
        };

      case 8:
        return {
          "nameAr":"الجزء ٨",
          "nameEng":"Juz 8",
          "number":8
        };

      case 9:
        return {
          "nameAr":"الجزء ٩",
          "nameEng":"Juz 9",
          "number":9
        };

      case 10:
        return {
          "nameAr":"الجزء ١٠",
          "nameEng":"Juz 10",
          "number":10
        };

      case 11:
        return {
          "nameAr":"الجزء ١١",
          "nameEng":"Juz 11",
          "number":11
        };

      case 12:
        return {
          "nameAr":"الجزء ١٢",
          "nameEng":"Juz 12",
          "number":12
        };

      case 13:
        return {
          "nameAr":"الجزء ١٣",
          "nameEng":"Juz 13",
          "number":13
        };

      case 14:
        return {
          "nameAr":"الجزء ١٤",
          "nameEng":"Juz 14",
          "number":14
        };

      case 15:
        return {
          "nameAr":"الجزء ١٥",
          "nameEng":"Juz 15",
          "number":15
        };

      case 16:
        return {
          "nameAr":"الجزء ١٦",
          "nameEng":"Juz 16",
          "number":16
        };

      case 17:
        return {
          "nameAr":"الجزء ١٧",
          "nameEng":"Juz 17",
          "number":17
        };

      case 18:
        return {
          "nameAr":"الجزء ١٨",
          "nameEng":"Juz 18",
          "number":18
        };

      case 19:
        return {
          "nameAr":"الجزء ١٩",
          "nameEng":"Juz 19",
          "number":19
        };

      case 20:
        return {
          "nameAr":"الجزء ٢٠",
          "nameEng":"Juz 20",
          "number":20
        };

      case 21:
        return {
          "nameAr":"الجزء ٢١",
          "nameEng":"Juz 21",
          "number":21
        };


      case 22:
        return {
          "nameAr":"الجزء ٢٢",
          "nameEng":"Juz 22",
          "number":22
        };

      case 23:
        return {
          "nameAr":"الجزء ٢٣",
          "nameEng":"Juz 23",
          "number":23
        };

      case 24:
        return {
          "nameAr":"الجزء ٢٤",
          "nameEng":"Juz 24",
          "number":24
        };

      case 25:
        return {
          "nameAr":"الجزء ٢٥",
          "nameEng":"Juz 25",
          "number":25
        };

      case 26:
        return {
          "nameAr":"الجزء ٢٦",
          "nameEng":"Juz 26",
          "number":26
        };

      case 27:
        return {
          "nameAr":"الجزء ٢٧",
          "nameEng":"Juz 27",
          "number":27
        };

      case 28:
        return {
          "nameAr":"الجزء ٢٨",
          "nameEng":"Juz 28",
          "number":28
        };

      case 29:
        return {
          "nameAr":"الجزء ٢٩",
          "nameEng":"Juz 29",
          "number":29
        };

      case 30:
        return {
          "nameAr":"الجزء ٣٠",
          "nameEng":"Juz 30",
          "number":30
        };
      default:
        return {
          "nameAr":"الجزء الأول",
          "nameEng":"1st Juz",
          "number":1
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return JuzItemWidget(
          arabicName: getJuzData(index+1)["nameAr"],
          englishName: getJuzData(index+1)["nameEng"],
          number: index+1,
          onTap: (){
            context.pushNamed(Routes.juzReadScreen, arguments: getJuzData(index+1));
          },
        );
      },
      separatorBuilder: (context, index) {
        return Separator();
      },
      itemCount: 30,
    );
  }
}
