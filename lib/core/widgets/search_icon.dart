import 'package:Quran/core/helpers/extensions.dart';
import 'package:Quran/core/routing/routes.dart';
import 'package:Quran/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../theming/assets.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.searchScreen);
      },
      child: SvgPicture.asset(
        Assets.searchIcon,
        color: AppColors.primaryColor,
      ),
    );
  }
}
