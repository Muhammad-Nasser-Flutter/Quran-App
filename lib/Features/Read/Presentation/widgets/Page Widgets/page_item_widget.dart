import 'package:Quran/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/custom_texts.dart';
import '../../../../../core/widgets/icon_widget.dart';

class PageItemWidget extends StatelessWidget {
  const PageItemWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.pageReadScreen, arguments: index+1);
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Text16(
            text: "${index + 1}",
            textColor: AppColors.defaultIconColor,
          ),
          IconWidget(
            iconAsset: Assets.bookIcon,
            size: 60,
          ),
        ],
      ),
    );
  }
}
