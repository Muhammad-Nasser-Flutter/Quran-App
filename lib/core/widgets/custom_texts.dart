import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theming/colors.dart';

// ignore: must_be_immutable
class Text12 extends StatelessWidget {
  final int? maxLines;
  final double? size;
  final Color? textColor;
  final double? height;
  final double? spacing;
  final String? family;
  final TextOverflow? overFlow;
  final TextAlign? alignment;
  final FontWeight? weight;
  final TextDecorationStyle? decorationStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final double? decorationThickness;

  const Text12({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: size ?? 12.sp,
        fontWeight: weight ?? FontWeight.w400,
        color: textColor ?? AppColors.smallTextColor,
        // (Theme.of(context).brightness == Brightness.light
        //     ? Colors.black
        //     : Colors.white),
        height: height,
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
        decorationColor: decorationColor,
        decoration: decoration,
        decorationThickness: decorationThickness,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text12Ar extends StatelessWidget {
  final int? maxLines;
  final double? size;
  final Color? textColor;
  final double? height;
  final double? spacing;
  final String? family;
  final TextOverflow? overFlow;
  final TextAlign? alignment;
  final FontWeight? weight;
  final TextDecorationStyle? decorationStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final double? decorationThickness;

  const Text12Ar({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.amiri(
        fontSize: size ?? 12.sp,
        fontWeight: weight ?? FontWeight.w400,
        color: textColor ?? AppColors.smallTextColor,
        // (Theme.of(context).brightness == Brightness.light
        //     ? Colors.black
        //     : Colors.white),
        height: height,
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
        decorationColor: decorationColor,
        decoration: decoration,
        decorationThickness: decorationThickness,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
      textDirection: TextDirection.rtl,
    );
  }
}

class Text14 extends StatelessWidget {
  final int? maxLines;
  final double? size;
  final Color? textColor;
  final double? height;
  final double? spacing;
  final String? family;
  final TextOverflow? overFlow;
  final TextAlign? alignment;
  final FontWeight? weight;
  final TextDecorationStyle? decorationStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final double? decorationThickness;

  const Text14({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: size ?? 14.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ?? AppColors.smallTextColor,
        // (Theme.of(context).brightness == Brightness.light
        //     ? Colors.black
        //     : Colors.white),
        height: height,
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
        decorationColor: decorationColor,
        decoration: decoration,
        decorationThickness: decorationThickness,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text14Ar extends StatelessWidget {
  final int? maxLines;
  final double? size;
  final Color? textColor;
  final double? height;
  final double? spacing;
  final String? family;
  final TextOverflow? overFlow;
  final TextAlign? alignment;
  final FontWeight? weight;
  final TextDecorationStyle? decorationStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final double? decorationThickness;

  const Text14Ar({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.amiri(
        fontSize: size ?? 14.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ?? AppColors.smallTextColor,
        // (Theme.of(context).brightness == Brightness.light
        //     ? Colors.black
        //     : Colors.white),
        height: height,
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
        decorationColor: decorationColor,
        decoration: decoration,
        decorationThickness: decorationThickness,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
      textDirection: TextDirection.rtl,
    );
  }
}

class Text16 extends StatelessWidget {
  final int? maxLines;
  final double? size;
  final Color? textColor;
  final double? height;
  final double? spacing;
  final String? family;
  final TextOverflow? overFlow;
  final TextAlign? alignment;
  final FontWeight? weight;
  final TextDecorationStyle? decorationStyle;
  const Text16({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      softWrap: true,
      text,
      style: GoogleFonts.poppins(
        fontSize: size ?? 16.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ?? AppColors.smallTextColor,
        // (Theme.of(context).brightness == Brightness.light
        //     ? Colors.black
        //     : Colors.white),
        height: height,
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text16Ar extends StatelessWidget {
  final int? maxLines;
  final double? size;
  final Color? textColor;
  final double? height;
  final double? spacing;
  final String? family;
  final TextOverflow? overFlow;
  final TextAlign? alignment;
  final FontWeight? weight;
  final TextDecorationStyle? decorationStyle;
  const Text16Ar({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      softWrap: true,
      text,
      style: GoogleFonts.amiri(
        fontSize: size ?? 16.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ?? AppColors.smallTextColor,
        // (Theme.of(context).brightness == Brightness.light
        //     ? Colors.black
        //     : Colors.white),
        height: height,
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
      textDirection: TextDirection.rtl,
    );
  }
}

class Text18 extends StatelessWidget {
  final int? maxLines;
  final double? size;
  final Color? textColor;
  final double? height;
  final double? spacing;
  final String? family;
  final TextOverflow? overFlow;
  final TextAlign? alignment;
  final FontWeight? weight;
  final TextDecorationStyle? decorationStyle;
  const Text18({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: size ?? 18.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ?? AppColors.bigTextColor,
        // (Theme.of(context).brightness == Brightness.light
        //     ? Colors.black
        //     : Colors.white),
        height: height,
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text18Ar extends StatelessWidget {
  final int? maxLines;
  final double? size;
  final Color? textColor;
  final double? height;
  final double? spacing;
  final String? family;
  final TextOverflow? overFlow;
  final TextAlign? alignment;
  final FontWeight? weight;
  final TextDecorationStyle? decorationStyle;
  const Text18Ar({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.amiri(
        fontSize: size ?? 18.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ?? AppColors.bigTextColor,
        // (Theme.of(context).brightness == Brightness.light
        //     ? Colors.black
        //     : Colors.white),
        height: height,
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
      textDirection: TextDirection.rtl,
    );
  }
}

class Text20 extends StatelessWidget {
  final int? maxLines;
  final double? size;
  final Color? textColor;
  final double? height;
  final double? spacing;
  final String? family;
  final TextOverflow? overFlow;
  final TextAlign? alignment;
  final FontWeight? weight;
  final TextDecorationStyle? decorationStyle;
  const Text20({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: size ?? 20.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ?? (Theme.of(context).brightness == Brightness.light ? AppColors.bigTextColor : Colors.white),
        height: height,
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text20Ar extends StatelessWidget {
  final int? maxLines;
  final double? size;
  final Color? textColor;
  final double? height;
  final double? spacing;
  final String? family;
  final TextOverflow? overFlow;
  final TextAlign? alignment;
  final FontWeight? weight;
  final TextDecorationStyle? decorationStyle;
  const Text20Ar({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.amiri(
        fontSize: size ?? 20.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ?? (Theme.of(context).brightness == Brightness.light ? AppColors.bigTextColor : Colors.white),
        height: height,
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
      textDirection: TextDirection.rtl,
    );
  }
}

class Text22 extends StatelessWidget {
  final int? maxLines;
  final double? size;
  final Color? textColor;
  final double? height;
  final double? spacing;
  final String? family;
  final TextOverflow? overFlow;
  final TextAlign? alignment;
  final FontWeight? weight;
  final TextDecorationStyle? decorationStyle;
  const Text22({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: size ?? 22.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ?? AppColors.bigTextColor,
        // (Theme.of(context).brightness == Brightness.light
        //     ? Colors.black
        //     : Colors.white),
        height: height,
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text22Ar extends StatelessWidget {
  final int? maxLines;
  final double? size;
  final Color? textColor;
  final double? height;
  final double? spacing;
  final String? family;
  final TextOverflow? overFlow;
  final TextAlign? alignment;
  final FontWeight? weight;
  final TextDecorationStyle? decorationStyle;
  const Text22Ar({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.amiri(
        fontSize: size ?? 22.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ?? AppColors.bigTextColor,
        // (Theme.of(context).brightness == Brightness.light
        //     ? Colors.black
        //     : Colors.white),
        height: height,
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
      textDirection: TextDirection.rtl,
    );
  }
}

class Text24 extends StatelessWidget {
  final int? maxLines;
  final double? size;
  final Color? textColor;
  final double? height;
  final double? spacing;
  final String? family;
  final TextOverflow? overFlow;
  final TextAlign? alignment;
  final FontWeight? weight;
  final TextDecorationStyle? decorationStyle;
  const Text24({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: size ?? 24.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ?? AppColors.bigTextColor,
        // (Theme.of(context).brightness == Brightness.light
        //     ? Colors.black
        //     : Colors.white),
        height: height,
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text24Ar extends StatelessWidget {
  final int? maxLines;
  final double? size;
  final Color? textColor;
  final double? height;
  final double? spacing;
  final String? family;
  final TextOverflow? overFlow;
  final TextAlign? alignment;
  final FontWeight? weight;
  final TextDecorationStyle? decorationStyle;
  const Text24Ar({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.amiri(
        fontSize: size ?? 24.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ?? AppColors.bigTextColor,
        // (Theme.of(context).brightness == Brightness.light
        //     ? Colors.black
        //     : Colors.white),
        height: height,
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
      textDirection: TextDirection.rtl,
    );
  }
}

class Text26 extends StatelessWidget {
  final int? maxLines;
  final double? size;
  final Color? textColor;
  final double? height;
  final double? spacing;
  final String? family;
  final TextOverflow? overFlow;
  final TextAlign? alignment;
  final FontWeight? weight;
  final TextDecorationStyle? decorationStyle;
  const Text26({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: size ?? 26.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ?? AppColors.bigTextColor,
        // (Theme.of(context).brightness == Brightness.light
        //     ? Colors.black
        //     : Colors.white),
        height: height,
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text26Ar extends StatelessWidget {
  final int? maxLines;
  final double? size;
  final Color? textColor;
  final double? height;
  final double? spacing;
  final String? family;
  final TextOverflow? overFlow;
  final TextAlign? alignment;
  final FontWeight? weight;
  final TextDecorationStyle? decorationStyle;
  const Text26Ar({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.amiri(
        fontSize: size ?? 26.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ?? AppColors.bigTextColor,
        // (Theme.of(context).brightness == Brightness.light
        //     ? Colors.black
        //     : Colors.white),
        height: height,
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
      textDirection: TextDirection.rtl,
    );
  }
}

class Text28 extends StatelessWidget {
  final int? maxLines;
  final double? size;
  final Color? textColor;
  final double? height;
  final double? spacing;
  final String? family;
  final TextOverflow? overFlow;
  final TextAlign? alignment;
  final FontWeight? weight;
  final TextDecorationStyle? decorationStyle;
  const Text28({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: size ?? 28.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ?? AppColors.bigTextColor,
        // (Theme.of(context).brightness == Brightness.light
        //     ? Colors.black
        //     : Colors.white),
        height: height,
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text28Ar extends StatelessWidget {
  final int? maxLines;
  final double? size;
  final Color? textColor;
  final double? height;
  final double? spacing;
  final String? family;
  final TextOverflow? overFlow;
  final TextAlign? alignment;
  final FontWeight? weight;
  final TextDecorationStyle? decorationStyle;
  const Text28Ar({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.amiri(
        fontSize: size ?? 28.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ?? AppColors.bigTextColor,
        // (Theme.of(context).brightness == Brightness.light
        //     ? Colors.black
        //     : Colors.white),
        height: height,
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
      textDirection: TextDirection.rtl,
    );
  }
}
