// menu_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/components/user_drawer.dart';
import 'package:sushi_app/cubit/cart/cart_cubit.dart';
import 'package:sushi_app/cubit/search/search_cubit.dart';
import 'package:sushi_app/cubit/search/search_state.dart';
import 'package:sushi_app/endpoints/endpoints.dart';
import 'package:sushi_app/models/menu.dart';
import 'package:sushi_app/pages/food_details_page.dart';
import 'package:sushi_app/services/data_service.dart';
import 'package:sushi_app/theme/colors.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  Future<List<Menus>>? _menu;

  @override
  void initState() {
    super.initState();
    _menu = DataService.fetchMenus('sushi');
  }

  void _navigateToDetail(Menus menu) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailsPage(menu: menu),
      ),
    );
  }

  // FAVORITE BUTTON
  bool _isLiked = true;

  void _toggleLiked() {
    setState(() {
      if (_isLiked) {
        _isLiked = false;
      } else {
        _isLiked = true;
      }
    });
  }

  // CATEGORY BUTTONS
  bool _isSushi = true;
  bool _isRamen = false;
  bool _isSides = false;

  void _categorySushi() {
    setState(() {
      if (!_isSushi) {
        _isSushi = true;
        _isRamen = false;
        _isSides = false;
        _menu = DataService.fetchMenus('sushi');
      }
    });
  }

  void _categoryRamen() {
    setState(() {
      if (!_isRamen) {
        _isSushi = false;
        _isRamen = true;
        _isSides = false;
        _menu = DataService.fetchMenus('ramen');
      }
    });
  }

  void _categorySides() {
    setState(() {
      if (!_isSides) {
        _isSushi = false;
        _isRamen = false;
        _isSides = true;
        _menu = DataService.fetchMenus('sides');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: const UserDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[800],
        elevation: 0,
        title: const Text(
          'Denpasar',
          textAlign: TextAlign.center,
        ),
        actions: [
          // CART BUTTON WITH BADGE
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<CartCubit>().resetNotificationCount();
                      Navigator.pushNamed(context, '/cart-page');
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),
                  if (state.notificationCount > 0)
                    Positioned(
                      right: 5,
                      top: 5,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${state.notificationCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SearchCubit(),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // PROMO BANNER
                    Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // PROMO MESSAGE
                              Text(
                                'COMING SOON!',
                                style: GoogleFonts.dmSerifDisplay(
                                  fontSize: 26,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                'Our new menu',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                'will release this July',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                          // IMAGE
                          Image.asset(
                            'assets/images/ramen_tori.png',
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // SEARCH BAR
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        onChanged: (value) {
                          context.read<SearchCubit>().startSearch(value);
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Search here..",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // CATEGORY WIDGET
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          // SUSHI WIDGET
                          GestureDetector(
                            onTap: _categorySushi,
                            child: Container(
                              decoration: _isSushi
                                  ? BoxDecoration(
                                      color: Colors.grey[600],
                                      borderRadius: BorderRadius.circular(20),
                                    )
                                  : BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // IMAGE
                                  Image.asset(
                                    'assets/images/salmon_sushi.png',
                                    height: 27,
                                  ),
                                  const SizedBox(width: 8),
                                  // TEXT
                                  const Text(
                                    "Sushi",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          // RAMEN WIDGET
                          GestureDetector(
                            onTap: _categoryRamen,
                            child: Container(
                              decoration: _isRamen
                                  ? BoxDecoration(
                                      color: Colors.grey[600],
                                      borderRadius: BorderRadius.circular(20),
                                    )
                                  : BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // IMAGE
                                  Image.asset(
                                    'assets/images/ramen.png',
                                    height: 27,
                                  ),
                                  const SizedBox(width: 8),
                                  // TEXT
                                  const Text(
                                    "Ramen",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          // SIDES WIDGET
                          GestureDetector(
                            onTap: _categorySides,
                            child: Container(
                              decoration: _isSides
                                  ? BoxDecoration(
                                      color: Colors.grey[600],
                                      borderRadius: BorderRadius.circular(20),
                                    )
                                  : BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // IMAGE
                                  Image.asset(
                                    'assets/images/dango.png',
                                    height: 27,
                                  ),
                                  const SizedBox(width: 8),
                                  // TEXT
                                  const Text(
                                    "Sides",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // MENU LIST
                    SafeArea(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: FutureBuilder<List<Menus>>(
                          future: _menu,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final menu = snapshot.data!;
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(menu.length, (index) {
                                    final item = menu[index];
                                    return SizedBox(
                                      width: 250,
                                      height: 250,
                                      child: ListTile(
                                        title: GestureDetector(
                                          onTap: () {
                                            _navigateToDetail(item);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            margin: const EdgeInsets.only(
                                                left: 10),
                                            padding: const EdgeInsets.all(25),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                // IMAGE
                                                Center(
                                                  child: Image.network(
                                                    '${Endpoints.ngrok}/${item.imagePath}',
                                                    height: 105,
                                                    fit: BoxFit.cover,
                                                    loadingBuilder:
                                                        (BuildContext context,
                                                            Widget child,
                                                            ImageChunkEvent?
                                                                loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      } else {
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            value: loadingProgress
                                                                        .expectedTotalBytes !=
                                                                    null
                                                                ? loadingProgress
                                                                        .cumulativeBytesLoaded /
                                                                    loadingProgress
                                                                        .expectedTotalBytes!
                                                                : null,
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                                // TEXT
                                                Text(
                                                  item.name,
                                                  style: GoogleFonts
                                                      .dmSerifDisplay(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                // PRICE + RATING
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      // PRICE
                                                      Text(
                                                        "RP${item.price}",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.grey[700],
                                                        ),
                                                      ),
                                                      // RATING
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color: Colors
                                                                .yellow[800],
                                                          ),
                                                          Text(
                                                            "${item.rating}",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('${snapshot.error}'),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Color.fromARGB(109, 140, 94, 91),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // POPULAR MENU WIDGET
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        "Popular Menu",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
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
                              Image.asset(
                                'assets/images/salmon_eggs.png',
                                height: 60,
                              ),
                              const SizedBox(width: 20),
                              // NAME AND PRICE
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // NAME
                                  Text(
                                    "Salmon Eggs",
                                    style: GoogleFonts.dmSerifDisplay(
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // PRICE
                                  Text(
                                    'RP 21.000',
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // HEART
                          IconButton(
                            onPressed: _toggleLiked,
                            icon: _isLiked
                                ? const Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey,
                                    size: 28,
                                  )
                                : const Icon(
                                    Icons.favorite,
                                    color: Color.fromARGB(255, 167, 41, 41),
                                    size: 28,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              // SEARCH RESULTS OVERLAY
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state.isSearching) {
                    return Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else if (state.showResults) {
                    return Container(
                      color: Colors.black.withOpacity(0.5),
                      child: ListView.builder(
                        itemCount: state.searchResults.length,
                        itemBuilder: (context, index) {
                          final menu = state.searchResults[index];
                          return ListTile(
                            title: Text(menu.name),
                            subtitle: Text("RP${menu.price}"),
                            onTap: () {
                              _navigateToDetail(menu);
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart'; 
// import 'package:sushi_app/components/user_drawer.dart';
// import 'package:sushi_app/cubit/cart/cart_cubit.dart';
// import 'package:sushi_app/endpoints/endpoints.dart';
// import 'package:sushi_app/models/menu.dart';
// import 'package:sushi_app/pages/food_details_page.dart';
// import 'package:sushi_app/services/data_service.dart';
// import 'package:sushi_app/theme/colors.dart';

// class MenuPage extends StatefulWidget {
//   const MenuPage({super.key});

//   @override
//   State<MenuPage> createState() => _MenuPageState();
// }

// class _MenuPageState extends State<MenuPage>
//     with SingleTickerProviderStateMixin {
//   Future<List<Menus>>? _menu;

//   @override
//   void initState() {
//     super.initState();
//    _menu = DataService.fetchMenus('sushi');
//   }

//   void _navigateToDetail(Menus menu) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FoodDetailsPage(menu: menu),
//       ),
//     );
//   }

//   //FAVORITE BUTTON
//   bool _isLiked = true;

//   void _toggleLiked() {
//     setState(() {
//       if (_isLiked) {
//         _isLiked = false;
//       } else {
//         _isLiked = true;
//       }
//     });
//   }

//   //CATEGORY BUTTON
//   bool _isSushi = true;
//   bool _isRamen = false;
//   bool _isSides = false;

//   void _categorySushi() {
//     setState(() {
//       if (!_isSushi) {
//         // Only change if _isSushi is currently false
//         _isSushi = true;
//         _isRamen = false;
//         _isSides = false;   
//         _menu = DataService.fetchMenus('sushi');

//       }
//     });
//   }

//   void _categoryRamen() {
//     setState(() {
//       if (!_isRamen) {
//         // Only change if _isRamen is currently false
//         _isSushi = false;
//         _isRamen = true;
//         _isSides = false;
//         _menu = DataService.fetchMenus('ramen');
//       }
//     });
//   }

//   void _categorySides() {
//     setState(() {
//       if (!_isSides) {
//         // Only change if _isSides is currently false
//         _isSushi = false;
//         _isRamen = false;
//         _isSides = true;
//         _menu = DataService.fetchMenus('sides');
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) { 
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       drawer: const UserDrawer(),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.grey[800],
//         elevation: 0,
//         title: const Text(
//           'Denpasar',
//           textAlign: TextAlign.center,
//         ),
//         actions: [
//           // CART BUTTON WITH BADGE
//           BlocBuilder<CartCubit, CartState>(
//             builder: (context, state) {
//               return Stack(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       context.read<CartCubit>().resetNotificationCount();
//                       Navigator.pushNamed(context, '/cart-page');
//                     },
//                     icon: const Icon(Icons.shopping_cart),
//                   ),
//                   if (state.notificationCount > 0)
//                     Positioned(
//                       right: 5,
//                       top: 5,
//                       child: Container(
//                         padding: const EdgeInsets.all(2),
//                         decoration: BoxDecoration(
//                           color: primaryColor,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         constraints: const BoxConstraints(
//                           minWidth: 16,
//                           minHeight: 16,
//                         ),
//                         child: Text(
//                           '${state.notificationCount}',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 10,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               //PROMO BANNER
//               Container(
//                 decoration: BoxDecoration(
//                     color: primaryColor,
//                     borderRadius: BorderRadius.circular(20)),
//                 margin: const EdgeInsets.symmetric(horizontal: 25),
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         //PROMO MESSAGE
//                         Text(
//                           'COMING SOON!',
//                           style: GoogleFonts.dmSerifDisplay(
//                             fontSize: 26,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(height: 15),
//                         const Text(
//                           'Our new menu',
//                           style: TextStyle(
//                             fontSize: 15,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const Text(
//                           'will release this July',
//                           style: TextStyle(
//                             fontSize: 15,
//                             color: Colors.white,
//                           ),
//                         ),

//                         const SizedBox(height: 10),
//                       ],
//                     ),

//                     //IMAGE
//                     Image.asset(
//                       'assets/images/ramen_tori.png',
//                       height: 100,
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               //SEARCH BAR
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Colors.white),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Colors.white),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       hintText: "Search here.."),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               //category widget
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: Row(
//                   children: [
//                     //sushi widget
//                     GestureDetector(
//                       onTap: _categorySushi,
//                       child: Container(
//                         decoration: (_isSushi
//                             ? BoxDecoration(
//                                 color: Colors.grey[600],
//                                 borderRadius: BorderRadius.circular(20),
//                               )
//                             : BoxDecoration(
//                                 color: Colors.grey[100],
//                                 borderRadius: BorderRadius.circular(20),
//                               )),
//                         padding: const EdgeInsets.all(8),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             //IMAGE
//                             Image.asset(
//                               'assets/images/tuna_salmon.png',
//                               height: 27,
//                             ),
//                             const SizedBox(width: 8),
//                             //TEXT
//                             const Text(
//                               "Sushi",
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     const SizedBox(width: 20),

//                     //ramen widget
//                     GestureDetector(
//                       onTap: _categoryRamen,
//                       child: Container(
//                         decoration: (_isRamen
//                             ? BoxDecoration(
//                                 color: Colors.grey[600],
//                                 borderRadius: BorderRadius.circular(20),
//                               )
//                             : BoxDecoration(
//                                 color: Colors.grey[100],
//                                 borderRadius: BorderRadius.circular(20),
//                               )),
//                         padding: const EdgeInsets.all(8),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             //IMAGE
//                             Image.asset(
//                               'assets/images/ramen.png',
//                               height: 27,
//                             ),
//                             const SizedBox(width: 8),
//                             //TEXT
//                             const Text(
//                               "Ramen",
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     const SizedBox(width: 20),

//                     //sides widget
//                     GestureDetector(
//                       onTap: _categorySides,
//                       child: Container(
//                         decoration: (_isSides
//                             ? BoxDecoration(
//                                 color: Colors.grey[600],
//                                 borderRadius: BorderRadius.circular(20),
//                               )
//                             : BoxDecoration(
//                                 color: Colors.grey[100],
//                                 borderRadius: BorderRadius.circular(20),
//                               )),
//                         padding: const EdgeInsets.all(8),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             //IMAGE
//                             Image.asset(
//                               'assets/images/shrimp.png',
//                               height: 27,
//                             ),
//                             const SizedBox(width: 8),
//                             //TEXT
//                             const Text(
//                               "Sides",
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 10),

//               SafeArea(
//                   child: SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 height: 250,
//                 child: FutureBuilder<List<Menus>>(
//                   future: _menu,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       final menu = snapshot.data!;
//                       return SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: List.generate(menu.length, (index) {
//                             final item = menu[index];
//                             return SizedBox(
//                               width: 250, // Adjust the width as needed
//                               height: 250, // Add margin to separate boxes
//                               child: ListTile(
//                                   title: GestureDetector(
//                                 onTap: () {
//                                   _navigateToDetail(item);
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey[100],
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   margin: const EdgeInsets.only(left: 10),
//                                   padding: const EdgeInsets.all(25),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       // IMAGE
//                                       Center(
//                                         child: Image.network(
//                                           '${Endpoints.ngrok}/${item.imagePath}',
//                                           height: 105,
//                                           fit: BoxFit.cover,
//                                           loadingBuilder: (BuildContext context,
//                                               Widget child,
//                                               ImageChunkEvent? loadingProgress) {
//                                             if (loadingProgress == null) {
//                                               return child;
//                                             } else {
//                                               return Center(
//                                                 child: CircularProgressIndicator(
//                                                   value: loadingProgress
//                                                               .expectedTotalBytes !=
//                                                           null
//                                                       ? loadingProgress
//                                                               .cumulativeBytesLoaded /
//                                                           loadingProgress
//                                                               .expectedTotalBytes!
//                                                       : null,
//                                                 ),
//                                               );
//                                             }
//                                           },
//                                         ),
//                                       ),
//                                       // TEXT
//                                       Text(
//                                         item.name,
//                                         style: GoogleFonts.dmSerifDisplay(
//                                             fontSize: 20),
//                                       ),
//                                       // PRICE + RATING
//                                       SizedBox(
//                                         width: MediaQuery.of(context)
//                                                 .size
//                                                 .width *
//                                             0.5, // Adjust the width as needed
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             // PRICE
//                                             Text(
//                                               "RP${item.price}",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.grey[700],
//                                               ),
//                                             ),
//                                             // RATING
//                                             Row(
//                                               children: [
//                                                 Icon(
//                                                   Icons.star,
//                                                   color: Colors.yellow[800],
//                                                 ),
//                                                 Text(
//                                                   "${item.rating}",
//                                                   style: const TextStyle(
//                                                       color: Colors.grey),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )),
//                             );
//                           }),
//                         ),
//                       );
//                     } else if (snapshot.hasError) {
//                       return Center(child: Text('${snapshot.error}'));
//                     }
//                     return const Center(
//                         child: CircularProgressIndicator(
//                       color: Color.fromARGB(109, 140, 94, 91),
//                     ));
//                   },
//                 ),
//               )),

//               const SizedBox(height: 20),
//               //POPULAR MENU WIDGET
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: Text(
//                   "Popular Menu",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey[800],
//                     fontSize: 18,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 10),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 margin: const EdgeInsets.only(left: 25, right: 25, bottom: 5),
//                 padding: const EdgeInsets.all(20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         //IMAGE
//                         Image.asset(
//                           'assets/images/salmon_eggs.png',
//                           height: 60,
//                         ),

//                         const SizedBox(width: 20),

//                         //NAME AND PRICE
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             //NAME
//                             Text(
//                               "Salmon Eggs",
//                               style: GoogleFonts.dmSerifDisplay(fontSize: 18),
//                             ),

//                             const SizedBox(height: 10),

//                             //PRICE
//                             Text(
//                               'RP 21.000',
//                               style: TextStyle(color: Colors.grey[700]),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),

//                     //HEART
//                     IconButton(
//                       onPressed: _toggleLiked,
//                       icon: (_isLiked
//                           ? const Icon(
//                               Icons.favorite_border,
//                               color: Colors.grey,
//                               size: 28,
//                             )
//                           : const Icon(
//                               Icons.favorite,
//                               color: Color.fromARGB(255, 167, 41, 41),
//                               size: 28,
//                             )),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
