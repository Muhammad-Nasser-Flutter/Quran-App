import 'package:Quran/Features/Main%20Layout/Presentation/widgets/bottom_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constant.dart';
import '../../../core/routing/app_router.dart';
import '../Bloc/main_layout_cubit.dart';
import '../Bloc/main_layout_state.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayoutCubit,MainLayoutState>(
      builder:(context,state){
        return Scaffold(
          body: PopScope(
            canPop: false,
            child: AppRouter().screens[mainLayoutInitialScreenIndex],
          ),
          bottomNavigationBar: const BottomBarWidget(),
        );
      },
    );
  }
}
