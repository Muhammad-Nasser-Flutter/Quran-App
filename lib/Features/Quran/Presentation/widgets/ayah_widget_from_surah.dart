import 'package:Quran/Features/Listen/models/position_data.dart';
import 'package:Quran/Features/Quran/Bloc/read_cubit.dart';
import 'package:Quran/Features/Quran/Bloc/read_states.dart';
import 'package:Quran/core/cache_helper/cache_helper.dart';
import 'package:Quran/core/theming/assets.dart';
import 'package:Quran/core/theming/colors.dart';
import 'package:Quran/core/widgets/custom_texts.dart';
import 'package:Quran/core/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran/quran.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utilies/easy_loading.dart';

class AyahWidgetFromSurah extends StatelessWidget {
  const AyahWidgetFromSurah(
      {super.key,
      required this.ayahNumber,
      required this.surahNumber,
      required this.isPlaying});
  final int ayahNumber;
  final int surahNumber;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadCubit, ReadStates>(builder: (context, state) {
      var cubit = ReadCubit.get(context);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Container(

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
                        text: ayahNumber.toString(),
                        textColor: Colors.white,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                  if (isSajdahVerse(surahNumber, ayahNumber))
                    IconWidget(
                      iconAsset: Assets.sagdaIcon,
                      size: 25.r,
                      color: AppColors.primaryColor,
                    ),
                  const Spacer(),
                  IconWidget(
                    iconAsset: Assets.shareIcon,
                    padding: 10,
                    size: 25.r,
                    color: AppColors.primaryColor,
                    onPressed: () {
                      Share.share(getVerse(surahNumber, ayahNumber));
                    },
                  ),
                  IconWidget(
                    iconAsset: (cubit.currentAyah?.numberInSurah == ayahNumber) &&
                            (cubit.currentAyah?.surahNumber == surahNumber)
                        ? isPlaying
                            ? Assets.pauseIcon
                            : Assets.playIcon
                        : Assets.playIcon,
                    padding: 10,
                    onPressed: () {
                      if (!isPlaying) {
                        ReadCubit.get(context)
                            .initializeAllAyahsFromSurah(surahNumber);
                        cubit.setCurrentAyah(
                          context: context,
                          ayahNumber: ayahNumber,
                          surahNumber: surahNumber,
                          startingAyahNumber: 1,
                        );
                      } else {
                        if (!cubit.audioPlayer.playing) {
                          cubit.audioPlayer.play();
                        } else {
                          cubit.audioPlayer.pause();
                        }
                      }
                    },
                  ),
                  IconWidget(
                    iconAsset: CacheHelper.lastReadAyah()==ayahNumber&&CacheHelper.lastReadSurah()==surahNumber?Assets.saveFillIcon:Assets.saveIcon,
                    padding: 10,
                    size: 25.r,
                    color: AppColors.primaryColor,
                    onPressed: (){
                      cubit.setLastReadSurahAndAyah(surahNumber,ayahNumber);
                    },
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
                text: getVerse(surahNumber, ayahNumber),
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
                text: getVerseTranslation(
                  surahNumber,
                  ayahNumber,
                ),
                weight: FontWeight.w500,
                textColor: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      );
    });
  }
}
