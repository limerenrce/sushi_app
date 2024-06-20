import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/components/user_drawer.dart';
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
//  List<Menus> _filteredMenu = [];
//  late TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _menu = DataService.fetchMenus();
  }

  // void _fetchMenu() {
  //   BlocProvider.of<MenuCubit>(context).fetchMenu(_searchController.text);
  // }

  void _navigateToDetail(Menus menu) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailsPage(menu: menu),
      ),
    );
  }

  //sort out and return a list of food items that belong to a specific category
  // List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
  //   return fullMenu.where((food) => food.category == category).toList();
  // }

  //return list of foods in given category
  // List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
  //   return FoodCategory.values.map((category) {
  //     //get category menu
  //     List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);

  //     return Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: ListView.builder(
  //         scrollDirection: Axis.horizontal,
  //         itemCount: categoryMenu.length,
  //         itemBuilder: (context, index) {
  //           //get individual food
  //           final food = categoryMenu[index];

  //           //return food tile UI
  //           return FoodTile(
  //             food: food,
  //             onTap: () => Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => FoodDetailsPage(food: food),
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     );
  //   }).toList();
  // }

  //FAVORITE BUTTON
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

  @override
  Widget build(BuildContext context) {
    //GET THE SHOP AND ITS MENU

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
          //CART BUTTON
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart-page');
            },
            icon: const Icon(
              Icons.shopping_cart,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //PROMO BANNER
              Container(
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //PROMO MESSAGE
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

                    //IMAGE
                    Image.asset(
                      'assets/images/ramen_tori.png',
                      height: 100,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              //SEARCH BAR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "Search here.."),
                ),
              ),

              const SizedBox(height: 20),

              //category widget
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    //sushi widget
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //IMAGE
                            Image.asset(
                              'assets/images/tuna_salmon.png',
                              height: 27,
                            ),
                            const SizedBox(width: 8),
                            //TEXT
                            const Text(
                              "Sushi",
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    //ramen widget
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //IMAGE
                            Image.asset(
                              'assets/images/ramen.png',
                              height: 27,
                            ),
                            const SizedBox(width: 8),
                            //TEXT
                            const Text(
                              "Ramen",
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    //sides widget
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //IMAGE
                            Image.asset(
                              'assets/images/shrimp.png',
                              height: 27,
                            ),
                            const SizedBox(width: 8),
                            //TEXT
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

              // //MENU TAB BARS
              // MyTabBar(tabController: _tabController),

              // //MENU TAB VIEWS
              // Expanded(
              //   child: Consumer<Restaurant>(
              //     builder: (context, restaurant, child) => TabBarView(
              //       controller: _tabController,
              //       children: getFoodInThisCategory(restaurant.foodMenu),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 10),

              // BlocBuilder<MenuCubit, MenuState>(
              //   builder: (context, state) {
              //     if (state.isLoading) {
              //       return Center(
              //           child: CircularProgressIndicator(
              //         color: primaryColor,
              //       ));
              //     } else if (state.errorMessage.isNotEmpty) {
              //       return Center(child: Text(state.errorMessage));
              //     } else if (state.menuList.isEmpty) {
              //       return const Center(child: Text('No menu available'));
              //     } else {
              //       return SingleChildScrollView(
              //         child: Row(
              //           children: [
              //             ListView.builder(
              //               itemCount: state.menuList.length,
              //               itemBuilder: (context, index) {
              //                 final menu = state.menuList[index];
              //                 return GestureDetector(
              //                   onTap: () {
              //                     _navigateToDetail(menu);
              //                   },
              //                   child: Container(
              //                     decoration: BoxDecoration(
              //                       color: Colors.grey[100],
              //                       borderRadius: BorderRadius.circular(20),
              //                     ),
              //                     margin: const EdgeInsets.only(left: 25),
              //                     padding: const EdgeInsets.all(25),
              //                     child: Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.spaceEvenly,
              //                       children: [
              //                         //IMAGE
              //                         Image.asset(
              //                           '${Endpoints.img}/${menu.imagePath}',
              //                           height: 105,
              //                         ),

              //                         //TEXT
              //                         Text(
              //                           menu.name,
              //                           style: GoogleFonts.dmSerifDisplay(
              //                               fontSize: 20),
              //                         ),

              //                         //PRICE + RATING
              //                         SizedBox(
              //                           width: 160,
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               //PRICE
              //                               Text(
              //                                 menu.price as String,
              //                                 style: TextStyle(
              //                                   fontWeight: FontWeight.bold,
              //                                   color: Colors.grey[700],
              //                                 ),
              //                               ),

              //                               //RATING
              //                               Row(
              //                                 children: [
              //                                   Icon(
              //                                     Icons.star,
              //                                     color: Colors.yellow[800],
              //                                   ),
              //                                   Text(
              //                                     menu.rating as String,
              //                                     style: const TextStyle(
              //                                         color: Colors.grey),
              //                                   ),
              //                                 ],
              //                               ),
              //                             ],
              //                           ),
              //                         )
              //                       ],
              //                     ),
              //                   ),
              //                 );
              //               },
              //             ),
              //           ],
              //         ),
              //       );
              //     }
              //   },
              // ),

              // SafeArea(
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: 250,
              //     child: SingleChildScrollView(
              //       scrollDirection: Axis.horizontal,
              //       child: Row(
              //         children: [
              //           FutureBuilder<List<Menus>>(
              //             future: _menu,
              //             builder: (context, snapshot) {
              //               if (snapshot.hasData) {
              //                 final menu = snapshot.data!;
              //                 return Row(
              //                   children: List.generate(menu.length, (index) {
              //                     final item = menu[index];
              //                     return Container(
              //                       width: 200,
              //                       height: 200,
              //                       child: ListTile(
              //                         title: item.imagePath != null
              //                             ? GestureDetector(
              //                                 onTap: () {_navigateToDetail(item);},
              //                                 child: Container(
              //                                   decoration: BoxDecoration(
              //                                     color: Colors.grey[100],
              //                                     borderRadius:
              //                                         BorderRadius.circular(20),
              //                                   ),
              //                                   margin:
              //                                       const EdgeInsets.only(left: 25),
              //                                   padding: const EdgeInsets.all(25),
              //                                   child: Column(
              //                                     crossAxisAlignment:
              //                                         CrossAxisAlignment.start,
              //                                     mainAxisAlignment:
              //                                         MainAxisAlignment.spaceEvenly,
              //                                     children: [
              //                                       // IMAGE
              //                                       Image.asset(
              //                                         '${Endpoints.img}/${item.imagePath}',
              //                                         height: 105,
              //                                       ),

              //                                       // TEXT
              //                                       Text(
              //                                         item.name,
              //                                         style:
              //                                             GoogleFonts.dmSerifDisplay(
              //                                                 fontSize: 20),
              //                                       ),

              //                                       // PRICE + RATING
              //                                       SizedBox(
              //                                         width: 160,
              //                                         child: Row(
              //                                           mainAxisAlignment:
              //                                               MainAxisAlignment
              //                                                   .spaceBetween,
              //                                           children: [
              //                                             // PRICE
              //                                             Text(
              //                                               "RP${item.price}",
              //                                               style: TextStyle(
              //                                                 fontWeight:
              //                                                     FontWeight.bold,
              //                                                 color: Colors.grey[700],
              //                                               ),
              //                                             ),

              //                                             // RATING
              //                                             Row(
              //                                               children: [
              //                                                 Icon(
              //                                                   Icons.star,
              //                                                   color: Colors
              //                                                       .yellow[800],
              //                                                 ),
              //                                                 Text(
              //                                                   "${item.rating}",
              //                                                   style:
              //                                                       const TextStyle(
              //                                                           color: Colors
              //                                                               .grey),
              //                                                 ),
              //                                               ],
              //                                             ),
              //                                           ],
              //                                         ),
              //                                       )
              //                                     ],
              //                                   ),
              //                                 ),
              //                               )
              //                             : null,
              //                       ),
              //                     );
              //                   }),
              //                 );
              //               } else if (snapshot.hasError) {
              //                 return Center(child: Text('${snapshot.error}'));
              //               }
              //               return const CircularProgressIndicator(
              //                   color: Color.fromARGB(109, 140, 94, 91));
              //             },
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

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
                              width: 250, // Adjust the width as needed
                              height: 250, // Add margin to separate boxes
                              child: ListTile(
                                  title: GestureDetector(
                                onTap: () {
                                  _navigateToDetail(item);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  margin: const EdgeInsets.only(left: 10),
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
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Center(
                                                child: CircularProgressIndicator(
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
                                        style: GoogleFonts.dmSerifDisplay(
                                            fontSize: 20),
                                      ),
                                      // PRICE + RATING
                                      SizedBox(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.5, // Adjust the width as needed
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // PRICE
                                            Text(
                                              "RP${item.price}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                            // RATING
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow[800],
                                                ),
                                                Text(
                                                  "${item.rating}",
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                            );
                          }),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('${snapshot.error}'));
                    }
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Color.fromARGB(109, 140, 94, 91),
                    ));
                  },
                ),
              )),

              const SizedBox(height: 20),
              //POPULAR MENU WIDGET
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
                margin: const EdgeInsets.only(left: 25, right: 25, bottom: 5),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        //IMAGE
                        Image.asset(
                          'assets/images/salmon_eggs.png',
                          height: 60,
                        ),

                        const SizedBox(width: 20),

                        //NAME AND PRICE
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //NAME
                            Text(
                              "Salmon Eggs",
                              style: GoogleFonts.dmSerifDisplay(fontSize: 18),
                            ),

                            const SizedBox(height: 10),

                            //PRICE
                            Text(
                              'RP 21.000',
                              style: TextStyle(color: Colors.grey[700]),
                            )
                          ],
                        ),
                      ],
                    ),

                    //HEART
                    IconButton(
                      onPressed: _toggleLiked,
                      icon: (_isLiked
                          ? const Icon(
                              Icons.favorite_border,
                              color: Colors.grey,
                              size: 28,
                            )
                          : const Icon(
                              Icons.favorite,
                              color: Color.fromARGB(255, 167, 41, 41),
                              size: 28,
                            )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
