import 'package:flutter/material.dart';

import '../../../../../core/widgets/separator.dart';
import 'hizb_item_widget.dart';

class HizbWidget extends StatelessWidget {
  const HizbWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return const HizbItemWidget(
          surah: "Al-Fatiha",
          page: "1",
          quarterNumber: "1",
          ayah: "بسم الله الرحمن الرحيم",
        );
      },
      separatorBuilder: (context, index) {
        return Separator();
      },
      itemCount: 10,
    );
  }
}
