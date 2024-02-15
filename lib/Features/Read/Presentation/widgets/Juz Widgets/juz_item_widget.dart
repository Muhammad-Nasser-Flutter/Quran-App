import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/custom_texts.dart';

class JuzItemWidget extends StatelessWidget {
  const JuzItemWidget({
    super.key,
    required this.englishName,
    required this.arabicName,
    required this.number,
  });
  final String englishName;
  final String arabicName;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                Assets.surahIcon,
              ),
              Text16(
                text: "1",
                textColor: Colors.black,
              )
            ],
          ),
          SizedBox(
            width: 15.w,
          ),
          Text18(
            text: englishName,
          ),
          const Spacer(),
          Text20Ar(
            text: arabicName,
            textColor: AppColors.primaryColor,
            weight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
