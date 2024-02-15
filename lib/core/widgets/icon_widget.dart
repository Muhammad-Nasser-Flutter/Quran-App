import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class IconWidget extends StatelessWidget {
  IconWidget({
    super.key,
    this.onPressed,
    required this.iconAsset,
    this.size,
    this.padding = 10,
    this.color,
  });
  VoidCallback? onPressed;
  final String iconAsset;
  double? size;
  double padding;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(padding.r),
        child: SvgPicture.asset(
          iconAsset,
          width: size,
          color: color,
        ),
      ),
    );
  }
}
