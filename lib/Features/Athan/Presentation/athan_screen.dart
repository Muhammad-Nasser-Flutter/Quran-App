import 'package:Quran/Features/Athan/bloc/athan_cubit.dart';
import 'package:Quran/core/theming/assets.dart';
import 'package:Quran/core/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/back.dart';
import '../../../core/widgets/custom_texts.dart';

class AthanScreen extends StatelessWidget {
  const AthanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text18(text: "Athan"),
        centerTitle: true,
        leading: const Back(),
      ),
      body: Center(
        child: Text18(text: "AthanScreen"),
      ),
    );
  }
}
