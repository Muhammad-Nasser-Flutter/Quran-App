import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/custom_texts.dart';


class HizbItemWidget extends StatelessWidget {
  const HizbItemWidget({super.key, required this.quarterNumber, required this.ayah, required this.surah, required this.page});
  final String quarterNumber;
  final String ayah;
  final String surah;
  final String page;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:5.w,vertical: 5.h),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Text16(text: "1st Juz"),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text18Ar(text: ayah),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text12(text: "Page $page  - $surah"),
                ],
              ),
              SizedBox(
                width: 10.w,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.circle_outlined,color: AppColors.primaryColor,size: 30.r),
                  Text14(text: quarterNumber,textColor: Colors.black,),

                ],
              ),

            ],
          )
        ],
      ),
    );
  }
}
