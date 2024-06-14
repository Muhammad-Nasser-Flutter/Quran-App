import 'package:Quran/Features/Read/Presentation/widgets/Surah%20widgets/surah_item_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/separator.dart';

class SurahWidget extends StatelessWidget {
  final bool fromRead;
  final int playingSurahNumber;
  const SurahWidget({super.key, required this.fromRead, required this.playingSurahNumber});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return SurahItemWidget(
          fromRead: fromRead,
          index:index,
          playingSurahNumber: playingSurahNumber,
        );
      },
      separatorBuilder: (context, index) {
        return Separator();
      },
      itemCount: 114,
    );
  }
}
