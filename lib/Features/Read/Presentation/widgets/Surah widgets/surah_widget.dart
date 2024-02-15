import 'package:Quran/Features/Read/Presentation/widgets/Surah%20widgets/surah_item_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/separator.dart';

class SurahWidget extends StatelessWidget {
  final bool fromRead;
  const SurahWidget({super.key, required this.fromRead});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return SurahItemWidget(
          englishName: "Al-Fatiha",
          arabicName: "الفاتحة",
          number: "1",
          versesNumber: "7",
          fromRead: fromRead,
          index:index,
        );
      },
      separatorBuilder: (context, index) {
        return Separator();
      },
      itemCount: 114,
    );
  }
}
