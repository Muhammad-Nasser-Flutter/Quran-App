import 'package:Quran/Features/Quran/Presentation/widgets/ayah_listen_widget.dart';
import 'package:Quran/Features/Quran/Presentation/widgets/quran_listen_top_widget.dart';
import 'package:Quran/core/theming/assets.dart';
import 'package:Quran/core/widgets/custom_texts.dart';
import 'package:Quran/core/widgets/icon_widget.dart';
import 'package:Quran/core/widgets/separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran/quran.dart';

import '../../../core/widgets/back.dart';

class QuranListenScreen extends StatelessWidget {
  const QuranListenScreen({super.key, required this.surahIndex});
  final int surahIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Back(),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text20(
          text: getSurahName(surahIndex),
          weight: FontWeight.w600,
        ),
        actions: [
          IconWidget(
            iconAsset: Assets.searchIcon,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              QuranListenTopWidget(index: surahIndex),
              SizedBox(
                height: 20.h,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return AyahListenWidget(ayahIndex: index+1, surahIndex: surahIndex);
                },
                separatorBuilder: (context, index) {
                  return Separator(
                    margin: 20.h,
                  );
                },
                itemCount: getVerseCount(surahIndex),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
