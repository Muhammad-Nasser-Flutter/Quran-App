import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/widgets/separator.dart';
import 'juz_item_widget.dart';

class JuzWidget extends StatelessWidget {
  const JuzWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return JuzItemWidget(
          arabicName: "الجزء الأول",
          englishName: "1st Juz",
          number: "1",
        );
      },
      separatorBuilder: (context, index) {
        return Separator();
      },
      itemCount: 10,
    );
  }
}
