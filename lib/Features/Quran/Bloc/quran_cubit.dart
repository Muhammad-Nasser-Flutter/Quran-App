import 'package:Quran/Features/Quran/Bloc/quran_states.dart';
import 'package:Quran/core/utilies/easy_loading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/Api/endPoints.dart';
import '../../../core/Api/my_dio.dart';
import '../models/quran_model.dart';
import '../models/surah_model.dart';

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


  List<SurahModel> surahs = [];
  Future<void> getQuranSurahs()async{
    try{
      showLoading();
      Response? response = await MyQuranDio.get(endPoint: EndPoints.quranSurahs);
      print(response?.data["data"]["surahs"]);

      if(response!.statusCode ==200){
        response.data["data"]["surahs"].forEach((element){
          surahs.add(SurahModel.fromJson(element));
        });
        emit(GetQuranSurahsSuccessState());
      }else{
        if (kDebugMode) {
          print(response.toString());
        }
        emit(GetQuranSurahsErrorState());
      }
      hideLoading();
    }catch(e){
      hideLoading();
      if (kDebugMode) {
        print(e.toString());
      }
      emit(GetQuranSurahsErrorState());

    }
  }
}
