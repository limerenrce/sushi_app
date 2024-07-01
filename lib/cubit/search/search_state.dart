// // search_state.dart

// import 'package:sushi_app/models/menu.dart';

// class SearchState {
//   final bool isSearching;
//   final List<Menus> searchResults;
//   final bool showResults;

//   SearchState({
//     required this.isSearching,
//     required this.searchResults,
//     required this.showResults,
//   });

//   factory SearchState.initial() {
//     return SearchState(
//       isSearching: false,
//       searchResults: [],
//       showResults: false,
//     );
//   }

//   SearchState copyWith({
//     bool? isSearching,
//     List<Menus>? searchResults,
//     bool? showResults,
//   }) {
//     return SearchState(
//       isSearching: isSearching ?? this.isSearching,
//       searchResults: searchResults ?? this.searchResults,
//       showResults: showResults ?? this.showResults,
//     );
//   }
// }
 

import 'package:flutter/material.dart';

import '../../models/menu.dart';

@immutable
class SearchState {
  final List<Menus> menuList;
  final bool isLoading;
  final String errorMessage;

  const SearchState({
    required this.menuList,
    required this.isLoading,
    required this.errorMessage,
  });

  const SearchState.initial()
      : menuList = const [],
        isLoading = false,
        errorMessage = '';
        

  SearchState copyWith({
    List<Menus>? menuList,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SearchState(
      menuList: menuList ?? this.menuList,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
