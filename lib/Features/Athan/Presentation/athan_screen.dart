import 'package:Quran/Features/Athan/bloc/athan_cubit.dart';
import 'package:Quran/core/theming/assets.dart';
import 'package:Quran/core/widgets/icon_widget.dart';
import 'package:Quran/core/widgets/loading_lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theming/colors.dart';
import '../../../core/widgets/back.dart';
import '../../../core/widgets/custom_texts.dart';
import '../bloc/athan_states.dart';
import 'package:easy_localization/easy_localization.dart';

class AthanScreen extends StatefulWidget {
  const AthanScreen({super.key});

  @override
  State<AthanScreen> createState() => _AthanScreenState();
}

class _AthanScreenState extends State<AthanScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AthanCubit.get(context).getPrayerTimesFromApi();
  }

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
          text: "Athan",
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
      body: Center(
        child: BlocBuilder<AthanCubit, AthanStates>(builder: (context, state) {
          var athanCubit = AthanCubit.get(context);
          if(state is GetPrayersLoadingState){
            return const LoadingLottie();
          }else if(state is GetPrayersErrorState){
            return Text18(text: "No Internet Connection");
          }
          return ListView.builder(
            itemCount: athanCubit.prayers.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor,
                      spreadRadius: -4,
                      blurRadius: 5.r,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
                      child: SvgPicture.asset(
                        Assets.azanIcon,
                        color: Colors.white,
                        fit: BoxFit.contain,
                        width: 25.r,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text18(
                      text: athanCubit.prayers[index]["key"],
                    ),
                    const Spacer(),
                    Text18(
                      text: DateFormat("hh:mm a").format(
                        DateTime.parse(
                            "2022-01-01 ${athanCubit.prayers[index]["value"].toString().split(" ")[0]}"),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
