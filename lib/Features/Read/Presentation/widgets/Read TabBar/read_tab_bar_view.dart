import 'package:flutter/material.dart';
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
        ],
      ),
    );
  }
}
