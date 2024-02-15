import 'package:Quran/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/quran.dart';
import 'package:quran/quran_text.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/custom_texts.dart';

class SurahItemWidget extends StatelessWidget {
  const SurahItemWidget({
    super.key,
    required this.englishName,
    required this.arabicName,
    required this.number,
    required this.versesNumber,
    required this.fromRead, required this.index,
  });
  final String englishName;
  final String arabicName;
  final String number;
  final String versesNumber;
  final bool fromRead;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(fromRead){
          context.pushNamed(Routes.quranScreen,arguments: index+1);
          // go to the surah's page where u can read the surah from the quran
        }else{
          // play the surah and go to the surah's page
          context.pushNamed(Routes.listeningScreen,arguments: index+1);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  Assets.surahIcon,
                  width: 40.r,
                ),
                Text14(
                  text: "${index+1}",
                  textColor: Colors.black,
                )
              ],
            ),
            SizedBox(
              width: 15.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text18(
                  text: getSurahName(index+1),
                ),
                Text12(
                  text: "${getPlaceOfRevelation(index+1)} - ${getVerseCount(index+1)} VERSES",
                ),
              ],
            ),
            const Spacer(),
            Text20Ar(
              text: getSurahNameArabic(index+1),
              textColor: AppColors.primaryColor,
              weight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
