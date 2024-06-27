// search_state.dart
import 'package:sushi_app/models/menu.dart';

class SearchState {
  final bool isSearching;
  final List<Menus> searchResults;
  final bool showResults;

  SearchState({
    required this.isSearching,
    required this.searchResults,
    required this.showResults,
  });

  factory SearchState.initial() {
    return SearchState(
      isSearching: false,
      searchResults: [],
      showResults: false,
    );
  }

  SearchState copyWith({
    bool? isSearching,
    List<Menus>? searchResults,
    bool? showResults,
  }) {
    return SearchState(
      isSearching: isSearching ?? this.isSearching,
      searchResults: searchResults ?? this.searchResults,
      showResults: showResults ?? this.showResults,
    );
  }
}
