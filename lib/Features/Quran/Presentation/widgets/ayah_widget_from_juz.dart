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

class AyahWidgetFromJuz extends StatelessWidget {
  const AyahWidgetFromJuz(
      {super.key, required this.ayahNumber, required this.data, });
  final int ayahNumber;
  final Map<String,dynamic> data;



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
                        size: 34.r,
                      ),
                    ),
                    Text14(
                      text: (ayahNumber+data["startingAyah"]-1).toString(),
                      textColor: Colors.white,
                      weight: FontWeight.w400,
                    ),
                  ],
                ),
                if (isSajdahVerse(data["surahNumber"], (ayahNumber+data["startingAyah"]-1).toInt()))
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
                          iconAsset:snapshot.data?.sequenceState?.currentSource?.tag?.id!=(ayahNumber+data["startingAyah"]-1).toString()
                              ? Assets.playIcon
                              : positionData!.playerState.playing &&data["surahNumber"].toString() ==mediaItem.album.toString()
                              ? Assets.pauseIcon
                              : Assets.playIcon,
                          padding: 10,
                          onPressed: () {
                            if(mediaItem.id == (ayahNumber+data["startingAyah"]-1).toString() &&data["surahNumber"].toString() ==mediaItem.album.toString()){
                              if (!positionData!.playerState.playing) {
                                cubit.audioPlayer!.play();
                              } else if (positionData
                                  .playerState.processingState !=
                                  ProcessingState.completed) {
                                cubit.audioPlayer!.pause();
                              }
                            }else{
                              print("${data["surahNumber"]} : ${data["numberOfAyahs"]}");
                              cubit.initializeAllAyahsFromJuz(data);
                              cubit.setCurrentAyah(
                                context: context,
                                ayahNumber: (ayahNumber+data["startingAyah"]-1).toInt(),
                                surahNumber: data["surahNumber"],
                                startingAyahNumber: data["startingAyah"],
                              );
                            }
                          },
                        );
                      }),
                if (cubit.audioPlayer == null)
                  IconWidget(
                    iconAsset: Assets.playIcon,
                    padding: 10,
                    onPressed: () {
                      cubit.initializeAllAyahsFromJuz(data);
                      print("${data["surahNumber"]} : ${data["numberOfAyahs"]} : ${(ayahNumber + data["startingAyah"] - 1).toInt()}");
                      cubit.setCurrentAyah(
                        context: context,
                        ayahNumber: (ayahNumber+data["startingAyah"]-1).toInt(),
                        surahNumber: data["surahNumber"],
                        startingAyahNumber: data["startingAyah"],
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
              text: getVerse(data["surahNumber"], (ayahNumber+data["startingAyah"]-1).toInt()),
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
                (ayahNumber+data["startingAyah"]-1).toInt(),
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
