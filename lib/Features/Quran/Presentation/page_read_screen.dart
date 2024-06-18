import 'package:Quran/Features/Listen/models/position_data.dart';
import 'package:Quran/Features/Quran/Presentation/widgets/ayah_widget_from_juz.dart';
import 'package:Quran/Features/Quran/Presentation/widgets/ayah_widget_from_page.dart';
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

class PageReadScreen extends StatelessWidget {
  const PageReadScreen({super.key, required this.pageNumber});
  final int pageNumber;

  List<Map<String, dynamic>> getPageSurahList() {
    List<Map<String, dynamic>> mapList = [];

    getPageData(pageNumber).forEach((value) {
      mapList.add({
        "surahNumber": value["surah"],
        "numberOfAyahs": value["end"] - value["start"] + 1,
        "startingAyah": value["start"],
        "endingAyah": value["end"]
      });
    });
    return mapList;
  }

  @override
  Widget build(BuildContext context) {
    print(getPageSurahList());
    return Scaffold(
      appBar: AppBar(
        leading: const Back(),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text20(
          text: "Page $pageNumber",
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
                                  index: getPageSurahList()[surahIndex]
                                      ["surahNumber"]),
                              SizedBox(
                                height: 20.h,
                              ),
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return AyahWidgetFromPage(
                                    isPlaying:
                                        cubit.currentAyah?.numberInSurah ==
                                                index + 1 &&
                                            cubit.currentAyah?.surahNumber ==
                                                getPageSurahList()[surahIndex]
                                                    ["surahNumber"],
                                    ayahNumber: index + 1,
                                    data: getPageSurahList()[surahIndex],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Separator(
                                    margin: 20.h,
                                  );
                                },
                                itemCount: getPageSurahList()[surahIndex]
                                    ['numberOfAyahs'],
                              ),
                            ],
                          );
                        },
                        itemCount: getPageSurahList().length,
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
