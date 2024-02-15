import 'package:Quran/Features/Quran/Bloc/quran_states.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/Api/endPoints.dart';
import '../../../core/Api/my_dio.dart';
import '../models/quran_model.dart';

class QuranCubit extends Cubit<QuranStates> {
  QuranCubit() : super(QuranInitialState());
  static QuranCubit get(context) => BlocProvider.of(context);
  QuranModel? quran;
  Future<void> getQuranData(int page)async{
    try{
      Response? response = await MyQuranDio.get(endPoint: EndPoints.quranPageUrl(page));
      if(response!.statusCode ==200){
        quran = QuranModel.fromJson(response.data);

        print(response.data["surahs"]);
        emit(GetQuranSuccessState());
      }else{
        if (kDebugMode) {
          print(response.toString());
        }
        emit(GetQuranErrorState());
      }
    }catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
      emit(GetQuranErrorState());

    }

  }
}
