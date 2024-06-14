import 'package:Quran/Features/Quran/Bloc/read_cubit.dart';
import 'package:Quran/Features/Quran/Presentation/widgets/ayah_listen_widget.dart';
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

class QuranReadScreen extends StatelessWidget {
  const QuranReadScreen({super.key, required this.surahNumber});
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
      body: BlocBuilder<ReadCubit, ReadStates>(
        builder: (context, state) {
          return PopScope(
            onPopInvoked: (b) {
              ReadCubit.get(context).removePlayer();
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
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return AyahReadWidget(ayahNumber: index+1, surahNumber: surahNumber);
                        },
                        separatorBuilder: (context, index) {
                          return Separator(
                            margin: 20.h,
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
        }
      ),
    );
  }
}
