import 'package:Quran/core/theming/assets.dart';
import 'package:Quran/core/theming/colors.dart';
import 'package:Quran/core/widgets/custom_texts.dart';
import 'package:Quran/core/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran/quran.dart';

class AyahListenWidget extends StatelessWidget {
  const AyahListenWidget(
      {super.key, required this.ayahIndex, required this.surahIndex});
  final int ayahIndex;
  final int surahIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: const Color(0xFFf3f3f5),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.circle,
                      color: AppColors.primaryColor,
                      size: 32.r,
                    ),
                  ),
                  Text14(
                    text: ayahIndex.toString(),
                    textColor: Colors.white,
                    weight: FontWeight.w400,
                  ),
                ],
              ),
              if (isSajdahVerse(surahIndex, ayahIndex))
                IconWidget(
                  iconAsset: Assets.sagdaIcon,
                  size: 25.r,
                  color: AppColors.primaryColor,
                ),
              const Spacer(),
              IconWidget(
                iconAsset: Assets.shareIcon,
                padding: 10,
              ),
              IconWidget(
                iconAsset: Assets.playIcon,
                padding: 10,
                onPressed: (){
                  print(getAudioURLByVerse(surahIndex, ayahIndex));
                },
              ),
              IconWidget(
                iconAsset: Assets.saveIcon,
                padding: 10,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          alignment: AlignmentDirectional.centerEnd,
          child: Text18Ar(
            text: getVerse(surahIndex, ayahIndex),
            height: 1.8,
            weight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          alignment: AlignmentDirectional.centerStart,
          child: Text16(
            text: getVerseTranslation(surahIndex, ayahIndex,),
            weight: FontWeight.w500,
            textColor: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
