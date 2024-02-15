import 'package:Quran/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/quran.dart';

import '../../../../core/theming/assets.dart';
import '../../../../core/widgets/custom_texts.dart';

class QuranListenTopWidget extends StatelessWidget {
  const QuranListenTopWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor,
            spreadRadius: -10,
            blurRadius: 15.r,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(Assets.quranListenScreenImage),
          Positioned(
            top: 25.r,
            child: Column(
              children: [
                Text26(
                  text: getSurahName(index),
                  textColor: Colors.white,
                  weight: FontWeight.w500,
                  spacing: 1,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text18Ar(
                  text: getSurahNameEnglish(index),
                  spacing: 0,
                  textColor: Colors.white,
                  weight: FontWeight.w600,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 1,
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  color: Colors.white.withOpacity(0.5),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text14(
                  text: "MECCAN - ${getVerseCount(index)} Verses",
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 30.h,
                ),
                SvgPicture.asset(Assets.basmala),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
