import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant.dart';
import '../../../../core/theming/assets.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/custom_texts.dart';
import '../../../../core/widgets/icon_widget.dart';
import '../../Bloc/main_layout_cubit.dart';
import '../../Bloc/main_layout_state.dart';


class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayoutCubit,MainLayoutState>(
      builder:(context,state){
        var cubit = MainLayoutCubit.get(context);
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 20.r,
                    spreadRadius: -1,
                    offset: const Offset(0, -10)),
              ],
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        cubit.changeBottomNavBar(0);
                      },
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Text14(
                              text: "READ",
                              textColor: mainLayoutInitialScreenIndex == 0
                                  ? AppColors.primaryColor
                                  : Colors.grey,
                            ),
                            IconWidget(
                              padding: 0,
                              iconAsset: Assets.readIcon,
                              color: mainLayoutInitialScreenIndex == 0
                                  ? AppColors.primaryColor
                                  : Colors.grey,
                              size: 30.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        cubit.changeBottomNavBar(1);
                      },
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Text14(
                              text: "LISTEN",
                              textColor: mainLayoutInitialScreenIndex == 1
                                  ? AppColors.primaryColor
                                  : Colors.grey,
                            ),
                            IconWidget(
                              padding: 0,
                              iconAsset: Assets.listeningIcon,
                              color: mainLayoutInitialScreenIndex == 1
                                  ? AppColors.primaryColor
                                  : Colors.grey,
                              size: 30.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        cubit.changeBottomNavBar(2);
                      },
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Text14(
                              text: "ATHAN",
                              textColor: mainLayoutInitialScreenIndex == 2 ? AppColors.primaryColor :  Colors.grey,
          
                            ),
                            IconWidget(
                              padding: 0,
                              iconAsset: Assets.azanIcon,
                              color: mainLayoutInitialScreenIndex == 2
                                  ? AppColors.primaryColor
                                  : Colors.grey.shade600,
                              size: 30.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
