import 'package:Quran/Features/Listen/Bloc/listen_cubit.dart';
import 'package:Quran/Features/Listen/Bloc/listen_states.dart';
import 'package:Quran/Features/Listen/models/position_data.dart';
import 'package:Quran/Features/Quran/Bloc/read_cubit.dart';
import 'package:Quran/Features/Quran/Bloc/read_states.dart';
import 'package:Quran/Features/Quran/models/surah_model.dart';
import 'package:Quran/core/cache_helper/cache_helper.dart';
import 'package:Quran/core/cache_helper/cache_values.dart';
import 'package:Quran/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/quran.dart';
import 'package:quran/quran_text.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/utilies/easy_loading.dart';
import '../../../../../core/widgets/custom_texts.dart';

class SurahItemWidget extends StatelessWidget {
  const SurahItemWidget({
    super.key,
    required this.fromRead,
    required this.index,
    // required this.playingSurahNumber,
  });
  // final int playingSurahNumber;
  final bool fromRead;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListenCubit, ListenStates>(
      builder: (context, state) {
        var listenCubit = ListenCubit.get(context);
        return InkWell(
          onTap: () {
            if (fromRead) {

              context.pushNamed(Routes.surahReadScreen, arguments: index + 1);
              // go to the surah's page where u can read the surah from the quran
            } else {
              // print(quranCubit.surahs[index]);
              // play the surah and go to the surah's page
              showLoading();
              listenCubit.setCurrentSurah(
                surahIndex: index,
              );
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
                      text: "${index + 1}",
                      textColor: Colors.black,
                    )
                  ],
                ),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text18(
                            text: getSurahName(index + 1),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          if (listenCubit.audioPlayer.sequence != null&&!fromRead)
                            StreamBuilder<PositionData>(
                                stream: listenCubit.positionDataStream,
                                builder: (context, snapshot) {
                                  if (snapshot.data?.sequenceState
                                          ?.currentSource?.tag?.id !=
                                      (index + 1).toString()) {
                                    return const SizedBox();
                                  } else {
                                    return Text14(
                                      text: "Playing",
                                      textColor: AppColors.primaryColor,
                                      weight: FontWeight.w600,
                                    );
                                  }
                                }),
                        ],
                      ),
                      Text12(
                        text:
                            "${getPlaceOfRevelation(index + 1)} - ${getVerseCount(index + 1)} VERSES",
                      ),
                    ],
                  ),
                ),
                Text20Ar(
                  text: getSurahNameArabic(index + 1),
                  textColor: AppColors.primaryColor,
                  weight: FontWeight.w700,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
