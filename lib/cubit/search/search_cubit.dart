// search_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sushi_app/models/menu.dart';
import 'package:sushi_app/services/data_service.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState.initial());

  void startSearch(String query) async {
    emit(state.copyWith(isSearching: true, showResults: false));
    try {
      final results = await DataService.fetchMenus(query);
      emit(state.copyWith(
        isSearching: false,
        searchResults: results,
        showResults: true,
      ));
    } catch (e) {
      emit(state.copyWith(isSearching: false, showResults: true));
    }
  }

  void clearSearch() {
    emit(state.copyWith(searchResults: [], showResults: false));
  }
}
