import 'package:Quran/Features/Read/Presentation/widgets/Read%20TabBar/read_tab_bar.dart';
import 'package:Quran/Features/Read/Presentation/widgets/Read%20TabBar/read_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/theming/assets.dart';
import '../../../core/theming/colors.dart';
import '../../../core/widgets/custom_texts.dart';
import '../../../core/widgets/icon_widget.dart';

class ReadScreen extends StatelessWidget {
  const ReadScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconWidget(
          iconAsset: Assets.menuIcon,
          onPressed: () {},
          color: AppColors.primaryColor,
          padding: 15,
        ),
        title: Text20(
          text: "Quran Reading",
          weight: FontWeight.w600,
        ),
        centerTitle: true,
        actions: [
          IconWidget(
            iconAsset: Assets.searchIcon,
            onPressed: () {},
            color: AppColors.primaryColor,
            padding: 15,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.r,
          vertical: 5.r,
        ),
        child: DefaultTabController(
          length: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text20(
                text: "Asslamualaikum",
                textColor: Colors.grey,
                weight: FontWeight.w400,
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Stack(
                  children: [
                    Image.asset(
                      Assets.readTopPoster,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 22.r,
                      left: 20.r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                Assets.lastReadIcon,
                                width: 25.r,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text16(
                                text: "Last Read",
                                textColor: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text20(
                            text: "Al-Fatiha",
                            textColor: Colors.white,
                          ),
                          // SizedBox(
                          //   height: 5.h,
                          // ),
                          Text16(
                            text: "Ayah No: 1",
                            textColor: Colors.white,weight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              const ReadTabBar(),
              SizedBox(
                height: 10.h,
              ),
              const ReadTabBarView()
            ],
          ),
        ),
      ),
    );
  }
}
