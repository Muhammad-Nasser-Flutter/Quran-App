
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constant.dart';
import 'main_layout_state.dart';
class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit() : super(MainLayoutInitial());
  static MainLayoutCubit get(context) => BlocProvider.of(context);
  void changeBottomNavBar(index) {
    mainLayoutInitialScreenIndex = index;
    emit(AppBottomNavState(mainLayoutInitialScreenIndex));
  }


}
