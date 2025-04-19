import 'package:Quran/Features/Quran/Bloc/read_cubit.dart';
import 'package:Quran/Features/Quran/Presentation/widgets/ayah_widget_from_surah.dart';
import 'package:Quran/Features/Quran/Presentation/widgets/quran_listen_top_widget.dart';
import 'package:Quran/core/widgets/custom_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../core/widgets/back.dart';
import '../Bloc/read_states.dart';

class SurahReadScreen extends StatefulWidget {
  const SurahReadScreen({
    super.key,
    required this.surahNumber,
    this.scrollToAyahIndex = 0,
  });
  final int surahNumber;
  final int scrollToAyahIndex;

  @override
  State<SurahReadScreen> createState() => _SurahReadScreenState();
}

class _SurahReadScreenState extends State<SurahReadScreen> {
  @override
  void initState() {
    super.initState();
    // Delay to wait for the widgets to render
    if (widget.scrollToAyahIndex != 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToSavedAyah();
      });
    }
  }

  final itemKeyList = <GlobalKey>[];

  void scrollToSavedAyah() {
    _scrollController.scrollTo(
      index: widget.scrollToAyahIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  final ItemScrollController _scrollController = ItemScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Back(),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text20(
          text: getSurahName(widget.surahNumber),
          weight: FontWeight.w600,
        ),

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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ScrollablePositionedList.builder(
                      itemScrollController: _scrollController,
                      itemBuilder: (context, index) {
                        final key = GlobalKey();
                        itemKeyList.add(key);
                        if (index == 0) {
                          return QuranListenTopWidget(
                            index: widget.surahNumber,
                            key: key,
                          );
                        }
                        return AyahWidgetFromSurah(
                          key: key,
                          isPlaying: (cubit.currentAyah?.numberInSurah == index) &&
                              (cubit.currentAyah?.surahNumber == widget.surahNumber),
                          ayahNumber: index,
                          surahNumber: widget.surahNumber,
                        );
                      },
                      itemCount: getVerseCount(widget.surahNumber) + 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
