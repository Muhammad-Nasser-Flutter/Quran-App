import 'package:Quran/Features/Read/Presentation/widgets/Page%20Widgets/page_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PageWidget extends StatelessWidget {
  const PageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      addAutomaticKeepAlives: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 5.w,
        mainAxisSpacing: 5.h,
        childAspectRatio:1,
      ),
      itemCount: 604,
      itemBuilder: (context, index) {
        return PageItemWidget(index: index);
      },
    );
  }
}
