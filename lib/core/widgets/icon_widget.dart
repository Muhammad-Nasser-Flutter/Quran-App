import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
    this.onPressed,
    required this.iconAsset,
    this.size,
    this.padding = 10,
    this.color,
  });
  final VoidCallback? onPressed;
  final String iconAsset;
  final double? size;
  final double padding;
  final Color? color;

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
