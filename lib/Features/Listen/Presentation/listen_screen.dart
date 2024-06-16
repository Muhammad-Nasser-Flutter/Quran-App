import 'package:Quran/Features/Listen/Bloc/listen_cubit.dart';
import 'package:Quran/Features/Listen/Bloc/listen_states.dart';
import 'package:Quran/Features/Listen/models/position_data.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import '../../../core/theming/assets.dart';
import '../../../core/theming/colors.dart';
import '../../../core/widgets/custom_texts.dart';
import '../../../core/widgets/icon_widget.dart';
import '../../Read/Presentation/widgets/Surah widgets/surah_widget.dart';

class ListenScreen extends StatefulWidget {
  const ListenScreen({super.key});

  @override
  State<ListenScreen> createState() => _ListenScreenState();
}

class _ListenScreenState extends State<ListenScreen> {
  final int playingSurahNumber = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconWidget(
          iconAsset: Assets.menuIcon,
          onPressed: () {},
          color: AppColors.primaryColor,
          padding: 15,
        ),
        title: Text20(
          text: "Quran Listening",
          weight: FontWeight.w600,
        ),
        centerTitle: true,
        actions: [
          IconWidget(
            iconAsset: Assets.searchIcon,
            onPressed: () {},
            color: AppColors.primaryColor,
            padding: 15,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.r,
          vertical: 5.r,
        ),
        child: BlocBuilder<ListenCubit, ListenStates>(
          builder: (context, state) {
            var listenCubit = ListenCubit.get(context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text20(
                  text: "Asslamualaikum",
                  textColor: Colors.grey,
                  weight: FontWeight.w400,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.sizeOf(context).width),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            Assets.listenTopPoster,
                          ))),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 10.0),
                          child: listenCubit.audioPlayer == null
                              ? Center(child: Text14(text: "Waiting to Play..",textColor: Colors.black,),)
                              : StreamBuilder<PositionData>(
                                  stream: listenCubit.positionDataStream,
                                  builder: (context, snapshot) {
                                    final positionData = snapshot.data;
                                    final mediaItem = positionData
                                        ?.sequenceState?.currentSource?.tag;

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              Assets.lastReadIcon,
                                              width: 25.r,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text16(
                                              text: "Playing Now",
                                              textColor: Colors.white,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text20(
                                          text: mediaItem?.album ?? "Loading..",
                                          textColor: Colors.white,
                                        ),
                                        Text16(
                                          text: mediaItem?.artist ?? "",
                                          textColor: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Column(
                                          children: [
                                            ProgressBar(
                                              timeLabelLocation:
                                                  TimeLabelLocation.below,
                                              timeLabelTextStyle:
                                                  GoogleFonts.poppins(
                                                      fontSize: 13.sp,
                                                      color: Colors.black54),
                                              barHeight: 3,
                                              baseBarColor:
                                                  const Color(0xFF555b6a),
                                              bufferedBarColor: Colors.grey,
                                              progressBarColor: Colors.white,
                                              thumbColor: Colors.white,
                                              thumbGlowRadius: 20,
                                              thumbRadius: 7,
                                              progress:
                                                  positionData?.position ??
                                                      Duration.zero,
                                              buffered: positionData
                                                      ?.bufferedPosition ??
                                                  Duration.zero,
                                              total: positionData?.duration ??
                                                  Duration.zero,
                                              onSeek:
                                                  listenCubit.audioPlayer!.seek,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                  color: Colors.white
                                                      .withOpacity(0.6)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconWidget(
                                                    onPressed: () {
                                                      listenCubit
                                                          .seekToPrevSurah();
                                                    },
                                                    iconAsset: Assets.prevIcon,
                                                    size: 25.r,
                                                    color: Colors.black54,
                                                    padding: 5,
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  IconWidget(
                                                    onPressed: () {
                                                      if (!positionData!
                                                          .playerState
                                                          .playing) {
                                                        listenCubit.audioPlayer!
                                                            .play();
                                                      } else if (positionData
                                                              .playerState
                                                              .processingState !=
                                                          ProcessingState
                                                              .completed) {
                                                        listenCubit.audioPlayer!
                                                            .pause();
                                                      }
                                                    },
                                                    iconAsset: positionData
                                                                ?.playerState
                                                                .playing ==
                                                            null
                                                        ? Assets.playIcon
                                                        : !positionData!
                                                                .playerState
                                                                .playing
                                                            ? Assets.playIcon
                                                            : Assets.pauseIcon,
                                                    size: 30.r,
                                                    color: Colors.black54,
                                                    padding: 5,
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  IconWidget(
                                                    onPressed: () {
                                                      listenCubit
                                                          .seekToNextSurah();
                                                    },
                                                    iconAsset: Assets.nextIcon,
                                                    size: 25.r,
                                                    padding: 5,
                                                    color: Colors.black54,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }),
                        ),
                      ),
                      Image.asset(
                        Assets.headphonesImage,
                        width: 120,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: SurahWidget(
                    fromRead: false,
                    playingSurahNumber: listenCubit.playingSurahNumber(),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
