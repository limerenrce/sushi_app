// search_page.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sushi_app/cubit/search/search_cubit.dart';
import 'package:sushi_app/cubit/search/search_state.dart';
import 'package:sushi_app/models/menu.dart';
import 'package:sushi_app/pages/food_details_page.dart';

import '../endpoints/endpoints.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController;
  }

  void onChange() {
    // Dispatch search event with current search text
    context.read<SearchCubit>().fetchEvent(_searchController.text);
  }

  void onClear() {
    // Clear search text and update state
    _searchController.clear();
    context.read<SearchCubit>().fetchEvent('');
  }

  _navigateToDetail(Menus menu) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailsPage(menu: menu),
      ),
    );
  }

  String formatPrice(int price) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[800],
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => onChange(),
              decoration: InputDecoration(
                hintText: "Search here",
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.black),
                        onPressed: () {
                          _searchController.clear();
                          onClear();
                        },
                      )
                    : const Icon(Icons.search, color: Colors.black),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 20.0),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 8.0),
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.errorMessage.isNotEmpty) {
                    return Center(child: Text(state.errorMessage));
                  } else if (state.menuList.isEmpty) {
                    return Center(child: Text('No results found.'));
                  } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.menuList.length,
                    itemBuilder: (context, index) {
                      final menu = state.menuList[index];
                      return GestureDetector(
                        // onTap: _navigateToDetail(menu),
                        onTap: () => _navigateToDetail(menu),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.only(
                              left: 25, right: 25, bottom: 5),
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  // IMAGE
                                  CachedNetworkImage(
                                    imageUrl:
                                        '${Endpoints.ngrok}/${menu.imagePath}',
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(
                                      color: Colors.grey,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    height: 60,
                                  ),
                                  const SizedBox(width: 20),
                                  // NAME AND PRICE
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // NAME
                                      Text(
                                        menu.name,
                                        style: GoogleFonts.dmSerifDisplay(
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // PRICE
                                      Text(
                                        formatPrice(menu.price),
                                        // 'RP ${cartItem.menu.price * cartItem.quantity}',
                  
                                        style: TextStyle(color: Colors.grey[700]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // // HEART
                              // IconButton(
                              //   onPressed: _toggleLiked,
                              //   icon: _isLiked
                              //       ? const Icon(
                              //           Icons.favorite_border,
                              //           color: Colors.grey,
                              //           size: 28,
                              //         )
                              //       : const Icon(
                              //           Icons.favorite,
                              //           color: Color.fromARGB(255, 167, 41, 41),
                              //           size: 28,
                              //         ),
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
