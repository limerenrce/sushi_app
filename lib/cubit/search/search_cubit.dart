// search_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sushi_app/services/data_service.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState.initial());

  void fetchMenu(String search) async {
    emit(state.copyWith(isLoading: true));
    try {
      final menuList = await DataService.fetchAllMenus(search);
      emit(state.copyWith(
        menuList: menuList,
        isLoading: false,
        errorMessage: '',
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to fetch menu',
      ));
    }
  }

  // void startSearch(String query) async {
  //   emit(state.copyWith(isSearching: true, showResults: false));
  //   try {
  //     final results = await DataService.fetchAllMenus(); // Adjust to your actual data fetching method
  //     final filteredResults = _filterResults(results, query); // Filter results based on query
  //     emit(state.copyWith(
  //       isSearching: false,
  //       searchResults: filteredResults,
  //       showResults: true,
  //     ));
  //   } catch (e) {
  //     emit(state.copyWith(isSearching: false, showResults: true));
  //     // Handle error or log error message
  //     // ignore: avoid_print
  //     print('Error searching menus: $e');
  //   }
  // }

  // List<Menus> _filterResults(List<Menus> results, String query) {
  //   // Implement your own filtering logic based on your Menu model
  //   if (query.isEmpty) {
  //     return results; // Return all results if query is empty
  //   } else {
  //     return results.where((menu) =>
  //         menu.name.toLowerCase().contains(query.toLowerCase())).toList();
  //     // Example: Filter by menu name containing the query (case insensitive)
  //   }
  // }

  // void clearSearch() {
  //   emit(state.copyWith(searchResults: [], showResults: false));
  // }
}
