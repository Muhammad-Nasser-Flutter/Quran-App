import 'package:Quran/Features/Listen/models/position_data.dart';
import 'package:Quran/Features/Quran/Bloc/read_cubit.dart';
import 'package:Quran/Features/Quran/Bloc/read_states.dart';
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

class AyahWidgetFromSurah extends StatelessWidget {
  const AyahWidgetFromSurah(
      {super.key, required this.ayahNumber, required this.surahNumber});
  final int ayahNumber;
  final int surahNumber;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadCubit, ReadStates>(builder: (context, state) {
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
                ),
                if (cubit.audioPlayer != null)
                  StreamBuilder<PositionData>(
                      stream: cubit.positionDataStream,
                      builder: (context, snapshot) {
                        final positionData = snapshot.data;
                        final mediaItem =
                            positionData?.sequenceState?.currentSource?.tag;
                        return IconWidget(
                          iconAsset:snapshot.data?.sequenceState?.currentSource?.tag?.id!=ayahNumber.toString()
                              ? Assets.playIcon
                              : positionData!.playerState.playing&&snapshot.data?.sequenceState?.currentSource?.tag?.id==ayahNumber.toString()
                                  ? Assets.pauseIcon
                                  : Assets.playIcon,
                          padding: 10,
                          onPressed: () {
                            if(mediaItem.id != ayahNumber.toString()){
                              cubit.setCurrentAyah(
                                context: context,
                                ayahNumber: ayahNumber,
                                surahNumber: surahNumber,
                                startingAyahNumber: 1
                              );

                            }else{
                              if (!positionData!.playerState.playing) {
                                cubit.audioPlayer!.play();
                              } else if (positionData
                                  .playerState.processingState !=
                                  ProcessingState.completed) {
                                cubit.audioPlayer!.pause();
                              }
                            }
                          },
                        );
                      }),
                if (cubit.audioPlayer == null)
                  IconWidget(
                    iconAsset: Assets.playIcon,
                    padding: 10,
                    onPressed: () {
                      cubit.setCurrentAyah(
                        context: context,
                        ayahNumber: ayahNumber,
                        surahNumber: surahNumber,
                        startingAyahNumber: 1
                      );
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
      );
    });
  }
}
