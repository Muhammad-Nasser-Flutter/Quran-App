part of 'search_cubit_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}
final class SearchCubitLoading extends SearchState {}
final class SearchSuccess extends SearchState {
  final Map<dynamic, dynamic> searchResults;

  const SearchSuccess(this.searchResults);

  @override
  List<Object> get props => [searchResults];
}
