import 'package:Quran/Features/Listen/models/position_data.dart';
import 'package:Quran/Features/Quran/Bloc/read_cubit.dart';
import 'package:Quran/Features/Quran/Bloc/read_states.dart';
import 'package:Quran/core/theming/assets.dart';
import 'package:Quran/core/theming/colors.dart';
import 'package:Quran/core/utilies/easy_loading.dart';
import 'package:Quran/core/widgets/custom_texts.dart';
import 'package:Quran/core/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran/quran.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/cache_helper/cache_helper.dart';

class AyahWidgetFromPage extends StatelessWidget {
  const AyahWidgetFromPage({
    super.key,
    required this.ayahNumber,
    required this.data,
    required this.isPlaying,
  });
  final int ayahNumber;
  final Map<String, dynamic> data;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:10.r),
      child: BlocBuilder<ReadCubit, ReadStates>(builder: (context, state) {
        var cubit = ReadCubit.get(context);
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
                          size: 34.r,
                        ),
                      ),
                      Text14(
                        text: (ayahNumber + data["startingAyah"] - 1).toString(),
                        textColor: Colors.white,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                  if (isSajdahVerse(data["surahNumber"],
                      (ayahNumber + data["startingAyah"] - 1).toInt()))
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
                      Share.share(getVerse(data["surahNumber"], (data["startingAyah"]+ayahNumber-1)));
                    },
                  ),
                  IconWidget(
                    iconAsset: (cubit.currentAyah?.numberInSurah == ayahNumber) &&
                            (cubit.currentAyah?.surahNumber ==
                                data["surahNumber"])
                        ? isPlaying
                            ? Assets.pauseIcon
                            : Assets.playIcon
                        : Assets.playIcon,
                    padding: 10,
                    onPressed: () {
                      if (!isPlaying) {
                        cubit.setCurrentAyah(
                          context: context,
                          ayahNumber: ayahNumber,
                          surahNumber: data["surahNumber"],
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
                    iconAsset: CacheHelper.lastReadAyah() == (data["startingAyah"]+ayahNumber-1) &&
                            CacheHelper.lastReadSurah() == data["surahNumber"]
                        ? Assets.saveFillIcon
                        : Assets.saveIcon,
                    padding: 10,
                    size: 25.r,
                    color: AppColors.primaryColor,
                    onPressed: () {
                      cubit.setLastReadSurahAndAyah(
                          data["surahNumber"], data["startingAyah"]+ayahNumber-1);
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
                text: getVerse(data["surahNumber"],
                    (ayahNumber + data["startingAyah"] - 1).toInt()),
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
                  data["surahNumber"],
                  (ayahNumber + data["startingAyah"] - 1).toInt(),
                ),
                weight: FontWeight.w500,
                textColor: AppColors.primaryColor,
              ),
            ),
          ],
        );
      }),
    );
  }
}
