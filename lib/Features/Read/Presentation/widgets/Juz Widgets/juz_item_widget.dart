import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/custom_texts.dart';

class JuzItemWidget extends StatelessWidget {
  const JuzItemWidget({
    super.key,
    required this.englishName,
    required this.arabicName,
    required this.number, required this.onTap,
  });
  final String englishName;
  final String arabicName;
  final int number;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
                Text14(
                  text: number.toString(),
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
      ),
    );
  }
}
