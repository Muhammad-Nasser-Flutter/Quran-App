import 'package:Quran/Features/Listen/models/position_data.dart';
import 'package:Quran/Features/Quran/Bloc/read_cubit.dart';
import 'package:Quran/Features/Quran/Presentation/widgets/ayah_widget_from_surah.dart';
import 'package:Quran/Features/Quran/Presentation/widgets/quran_listen_top_widget.dart';
import 'package:Quran/core/theming/assets.dart';
import 'package:Quran/core/widgets/custom_texts.dart';
import 'package:Quran/core/widgets/icon_widget.dart';
import 'package:Quran/core/widgets/separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart';
import '../../../core/widgets/back.dart';
import '../Bloc/read_states.dart';

class SurahReadScreen extends StatelessWidget {
  const SurahReadScreen({super.key, required this.surahNumber});
  final int surahNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Back(),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text20(
          text: getSurahName(surahNumber),
          weight: FontWeight.w600,
        ),
        actions: [
          IconWidget(
            iconAsset: Assets.searchIcon,
          ),
        ],
      ),
      body: BlocBuilder<ReadCubit, ReadStates>(builder: (context, state) {
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
                      height: 10.h,
                    ),
                    QuranListenTopWidget(index: surahNumber),
                    SizedBox(
                      height: 20.h,
                    ),
                    ListView.builder(addAutomaticKeepAlives: false,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                          return AyahWidgetFromSurah(
                          isPlaying: cubit.currentAyah?.numberInSurah == index + 1&&cubit.currentAyah?.surahNumber==surahNumber,
                          ayahNumber: index + 1,
                          surahNumber: surahNumber,
                        );
                      },
                      itemCount: getVerseCount(surahNumber),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
