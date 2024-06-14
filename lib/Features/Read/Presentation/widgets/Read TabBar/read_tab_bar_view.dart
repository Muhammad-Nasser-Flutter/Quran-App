import 'package:Quran/Features/Listen/Bloc/listen_cubit.dart';
import 'package:Quran/Features/Listen/models/position_data.dart';
import 'package:flutter/material.dart';
import '../Hizb Widgets/hizb_widget.dart';
import '../Juz Widgets/juz_widget.dart';
import '../Page Widgets/page_widget.dart';
import '../Surah widgets/surah_widget.dart';

class ReadTabBarView extends StatelessWidget {
  const ReadTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: TabBarView(
        children: [
          SurahWidget(
            fromRead: true,
            playingSurahNumber:0,
          ),
          JuzWidget(),
          PageWidget(),
          HizbWidget(),
        ],
      ),
    );
  }
}
