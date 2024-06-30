import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sushi_app/cubit/search/search_cubit.dart';
import 'package:sushi_app/cubit/search/search_state.dart';
import 'package:sushi_app/models/menu.dart';

class SearchPage extends StatefulWidget {
  final List<Menus> menus;

  const SearchPage({super.key, required this.menus});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<Menus> filteredProducts;

  @override
  void initState() {
    // filteredProducts = widget.products;
    super.initState();
  }

  // void filterSearchResults(String query) {
  //   List<Menus> searchResults = searchProducts(widget.products, query);
  //   setState(() {
  //     filteredProducts = searchResults;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu List'),
      ),
      body: Column(
        children: [
           BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return Text(
                  '${state.searchResults}',
                  style: const TextStyle(fontSize: 24.0),
                );
              },
            ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     onChanged: (value) {
          //       filterSearchResults(value);
          //     },
          //     decoration: InputDecoration(
          //       hintText: 'Search...',
          //     ),
          //   ),
          // ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: filteredProducts.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return ListTile(
          //         title: Text(filteredProducts[index].name),
          //         subtitle: Text(filteredProducts[index].description),
          //         // Add more widgets to display additional info if needed
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
