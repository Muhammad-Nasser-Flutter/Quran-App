import 'dart:async';
import 'package:Quran/core/utilies/debouncer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart';

part 'search_cubit_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  final TextEditingController searchController = TextEditingController();

  void search() {
    var searchResults = <dynamic, dynamic>{};
    emit(SearchCubitLoading());
    searchResults = searchWords(searchController.text.split(' '));
    print("searchResults: $searchResults");
    emit(SearchSuccess(searchResults));
  }
}
