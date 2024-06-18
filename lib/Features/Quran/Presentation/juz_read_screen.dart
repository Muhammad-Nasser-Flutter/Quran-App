import 'package:Quran/Features/Listen/models/position_data.dart';
import 'package:Quran/Features/Quran/Presentation/widgets/ayah_widget_from_juz.dart';
import 'package:Quran/Features/Quran/Presentation/widgets/quran_listen_top_widget.dart';
import 'package:Quran/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart';
import '../../../core/theming/assets.dart';
import '../../../core/widgets/back.dart';
import '../../../core/widgets/custom_texts.dart';
import '../../../core/widgets/icon_widget.dart';
import '../../../core/widgets/separator.dart';
import '../Bloc/read_cubit.dart';
import '../Bloc/read_states.dart';

class JuzReadScreen extends StatelessWidget {
  const JuzReadScreen({super.key, required this.juzData});
  final Map<String, dynamic> juzData;

  List<Map<String, dynamic>> getJuzSurahList() {
    List<Map<String, dynamic>> mapList = [];

    getSurahAndVersesFromJuz(juzData['number']).forEach((key, value) {
      mapList.add({
        "surahNumber": key,
        "numberOfAyahs": value[1] - value[0] + 1,
        "startingAyah": value[0],
        "endingAyah": value[1]
      });
    });
    return mapList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Back(),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text20(
          text: juzData['nameEng'],
          weight: FontWeight.w600,
        ),
        actions: [
          IconWidget(
            iconAsset: Assets.searchIcon,
          ),
        ],
      ),
      body: BlocBuilder<ReadCubit, ReadStates>(
        builder: (context, state) {
          var cubit = ReadCubit.get(context);
          return PopScope(
            onPopInvoked: (b) {
              if (ReadCubit.get(context).audioPlayer.sequence != null) {
                ReadCubit.get(context).removePlayer();
              }
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, surahIndex) {
                          return Separator(
                            margin: 10,
                          );
                        },
                        itemBuilder: (context, surahIndex) {
                          return Column(
                            children: [
                              QuranListenTopWidget(
                                  index: getJuzSurahList()[surahIndex]
                                      ["surahNumber"]),
                              SizedBox(
                                height: 20.h,
                              ),
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return AyahWidgetFromJuz(
                                    isPlaying:
                                        cubit.currentAyah?.numberInSurah ==
                                                index + 1 &&
                                            cubit.currentAyah?.surahNumber ==
                                                getJuzSurahList()[surahIndex]
                                                    ["surahNumber"],
                                    ayahNumber: index + 1,
                                    data: getJuzSurahList()[surahIndex],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Separator(
                                    margin: 20.h,
                                  );
                                },
                                itemCount: getJuzSurahList()[surahIndex]
                                    ['numberOfAyahs'],
                              ),
                            ],
                          );
                        },
                        itemCount: getJuzSurahList().length,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
