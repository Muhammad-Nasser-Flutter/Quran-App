import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theming/colors.dart';

class ReadTabBar extends StatelessWidget {
  const ReadTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      padding: EdgeInsets.zero,
      automaticIndicatorColorAdjustment: true,
      indicatorColor: AppColors.primaryColor,
      unselectedLabelColor: AppColors.smallTextColor,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 3,
      dividerHeight: 3,
      dividerColor: Colors.grey.withOpacity(0.2),
      labelPadding: EdgeInsets.only(bottom: 5.h),
      tabs: [
        Padding(
          padding: EdgeInsets.all(5.r),
          child: Text(
            "Surah",
            style: GoogleFonts.poppins(fontSize: 18.r, fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.r),
          child: Text(
            "Juz",
            style: GoogleFonts.poppins(fontSize: 18.r, fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.r),
          child: Text(
            "Page",
            style: GoogleFonts.poppins(fontSize: 18.r, fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.r),
          child: Text(
            "Hizb",
            style: GoogleFonts.poppins(fontSize: 18.r, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
