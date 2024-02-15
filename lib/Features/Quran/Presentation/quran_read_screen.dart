import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theming/assets.dart';
import '../../../core/widgets/custom_texts.dart';
import '../Bloc/quran_cubit.dart';
import '../Bloc/quran_states.dart';


class QuranReadScreen extends StatelessWidget {
  const QuranReadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf6f8f7),
      body: BlocBuilder<QuranCubit,QuranStates>(
        builder:(context,state){
          var quranCubit = QuranCubit.get(context);
          return PageView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  Assets.surahBorderImage,
                                  height: 60.h,
                                  fit: BoxFit.fill,
                                  width: MediaQuery.sizeOf(context).width * 0.8,
                                ),
                                quranCubit.quran?.data?.ayahs?[0] !=null?
                                Text22Ar(
                                  text: "${quranCubit.quran?.data?.ayahs?[0].surah?.name}",
                                ):SizedBox(),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            // SvgPicture.asset(
                            //   Assets.basmala,
                            //   height: 50.r,
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),

                      quranCubit.quran !=null?
                      Expanded(
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            RichText(
                              textDirection: TextDirection.rtl,
                              text: TextSpan(
                                text: "",
                                children: <TextSpan>[

                                  for (int i = 0; i < quranCubit.quran!.data!.ayahs!.length; i++) ...{

                                    TextSpan(
                                      text:
                                      "${quranCubit.quran?.data?.ayahs?[i].text} (${quranCubit.quran?.data?.ayahs?[i].numberInSurah}) ",
                                      style: GoogleFonts.amiri().copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                  },
                                ],
                              ),
                            ),
                          ],
                        ),
                      ):
                      SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
