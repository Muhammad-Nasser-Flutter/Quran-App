import 'package:Quran/Features/Athan/bloc/athan_cubit.dart';
import 'package:Quran/core/theming/assets.dart';
import 'package:Quran/core/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/back.dart';
import '../../../core/widgets/custom_texts.dart';
import '../bloc/athan_states.dart';

class AthanScreen extends StatelessWidget {
  const AthanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text18(text: "Athan"),
        centerTitle: true,
      ),
      body: Center(
        child: BlocBuilder<AthanCubit,AthanStates>(
          builder: (context,state) {
            var athanCubit = AthanCubit.get(context);
            return ListView.builder(
              itemCount: athanCubit.prayers.length,
              itemBuilder: (context, index) {
                return Container();
              },
            );
          }
        ),
      ),
    );
  }
}
