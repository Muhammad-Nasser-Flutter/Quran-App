import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/theming/assets.dart';
import '../../../core/theming/colors.dart';
import '../../../core/widgets/custom_texts.dart';
import '../../../core/widgets/icon_widget.dart';
import '../../Read/Presentation/widgets/Surah widgets/surah_widget.dart';

class ListenScreen extends StatelessWidget {
  const ListenScreen({super.key});
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
        child: DefaultTabController(
          length: 4,
          child: Column(
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
              Center(
                child: Stack(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.sizeOf(context).width
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Image.asset(
                        Assets.listenTopPoster,
                        fit: BoxFit.cover,
                        width: double.maxFinite,
                        height: 200,
                      ),
                    ),
                    Positioned(
                      top: 15.r,
                      left: 20.r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                text: "Last Listen",
                                textColor: Colors.white,
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text20(
                            text: "Al-Fatiha",
                            textColor: Colors.white,
                          ),
                          Text16(
                            text: "Mushary Al-Afasy",
                            textColor: Colors.white,
                          ),
                          SizedBox(height: 10.h,),
                          SizedBox(
                            width: 180.w,
                            child: Column(
                              children: [
                                ProgressBar(
                                  timeLabelLocation: TimeLabelLocation.below,
                                  barHeight: 3,
                                  baseBarColor: const Color(0xFF555b6a),
                                  bufferedBarColor: Colors.grey,
                                  progressBarColor: Colors.white,
                                  thumbColor: Colors.white,
                                  thumbGlowRadius: 20,
                                  thumbRadius: 7,
                                  progress: const Duration(
                                    seconds: 20,
                                  ),
                                  total: const Duration(seconds: 100),
                                  onSeek: (Duration d) {
                                    // trackCubit.changeVolume(double.parse(
                                    //     (d.inSeconds / 100).toString()));
                                  },
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: Colors.black.withOpacity(0.6)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconWidget(
                                        onPressed: () {
                                          // trackCubit.seekToPrevTrack();
                                        },
                                        iconAsset: Assets.prevIcon,
                                        size: 25.r,
                                        color: Colors.white,
                                        padding: 5,

                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      IconWidget(
                                        onPressed: () {
                                          // if (!positionData!.playerState.playing) {
                                          //   trackCubit.audioPlayer!.play();
                                          // } else if (positionData
                                          //     .playerState.processingState !=
                                          //     ProcessingState.completed) {
                                          //   trackCubit.audioPlayer!.pause();
                                          // }
                                        },
                                        iconAsset:  Assets.playIcon,
                                        size: 30.r,
                                        color: Colors.white,
                                        padding: 5,

                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      IconWidget(
                                        onPressed: () {
                                          // trackCubit.seekToNextTrack();
                                        },
                                        iconAsset: Assets.nextIcon,
                                        size: 25.r,
                                        padding: 5,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 10.r,
                      child: Image.asset(
                        Assets.headphonesImage,
                        width: 140,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              const Expanded(
                child: SurahWidget(fromRead: false,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
