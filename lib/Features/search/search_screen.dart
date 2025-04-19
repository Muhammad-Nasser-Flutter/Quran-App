import 'package:Quran/Features/search/Bloc/cubit/search_cubit_cubit.dart';
import 'package:Quran/core/theming/colors.dart';
import 'package:Quran/core/utilies/debouncer.dart';
import 'package:Quran/core/widgets/back.dart';
import 'package:Quran/core/widgets/custom_text_form_field.dart';
import 'package:Quran/core/widgets/custom_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text18(text: "Search"),
        centerTitle: true,
        leading: Back(),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFormField(
                  borderColor: Colors.grey.shade500,
                  controller: context.read<SearchCubit>().searchController,
                  borderWidth: 1,
                  hintText: "Search",
                  onChanged: (value) {
                    Debouncer(milliseconds: 1000).run(() => context.read<SearchCubit>().search());
                  },
                  prefixIcon: const Icon(Icons.search),
                ),
                // if (state is SearchSuccess)
                // Expanded(
                //   child: ListView.builder(
                //     itemBuilder: (context, index) {

                //     },
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
