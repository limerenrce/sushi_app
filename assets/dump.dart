
// //   List<Menus> _filterMenuByCategory(List<Menus> allItems, String category) {
// //     return allItems.where((_menu) => _menu.category == category).toList();
// //   }

// //   List<Widget> getFoodInThisCategory(List<Menus> allItems) {

// //     return Menus.category.value.map((category) {
// //       List<Menus> categoryMenu = _filterMenuByCategory(allItems, category);

// //       return Padding(
// //           padding: const EdgeInsets.all(8.0),
// //           child: FutureBuilder<List<Menus>>(
// //             future: menu,
// //             builder: (context, snapshot) {
// //               if (snapshot.hasData) {
// //                 final menu = snapshot.data!;
// //                 return ListView.builder(
// //                   scrollDirection: Axis.horizontal,
// //                   itemCount: categoryMenu.length,
// //                   itemBuilder: (context, index) {
// //                     final menus = categoryMenu[index];
// //                     return FoodTile(
// //                       menus: menus,
// //                       onTap: () => Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => FoodDetailsPage(menu: menu),
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 );
// //               } else if (snapshot.hasError) {
// //                 return Center(child: Text('${snapshot.error}'));
// //               }
// //               return const Center(
// //                   child: CircularProgressIndicator(
// //                 color: Color.fromARGB(109, 140, 94, 91),
// //               ),);
// //             },
// //           ),);
// //     },);
// //   }

// //   ListView.builder(
// //         scrollDirection: Axis.horizontal,
// //         itemCount: categoryMenu.length,
// //         itemBuilder: (context, index) {
// //           final menus = categoryMenu[index];
// //           return FoodTile(
// //             menus: menus,
// //             onTap: () => Navigator.push(
// //               context,
// //               MaterialPageRoute(
// //                 builder: (context) => FoodDetailsPage(menus: menus),
// //               ),
// //             ),
// //           );
// //         },
// //       )

// //   get all menu
// //   )
// //   sort out and return a list of food items that belong to a specific category
// //   List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
// //     return fullMenu.where((food) => food.category == category).toList();
// //   }

// //   return list of foods in given category
// //   List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
// //     return FoodCategory.values.map((category) {
// //       //get category menu
// //       List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);

// //       return Padding(
// //         padding: const EdgeInsets.all(8.0),
// //         child: ListView.builder(
// //           scrollDirection: Axis.horizontal,
// //           itemCount: categoryMenu.length,
// //           itemBuilder: (context, index) {
// //             //get individual food
// //             final food = categoryMenu[index];

// //             //return food tile UI
// //             return FoodTile(
// //               food: food,
// //               onTap: () => Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (context) => FoodDetailsPage(food: food),
// //                 ),
// //               ),
// //             );
// //           },
// //         ),
// //       );
// //     }).toList();
// //   }


  
// //               //MENU TAB BARS
// //               MyTabBar(tabController: _tabController),

// //               //MENU TAB VIEWS
// //               Expanded(
// //                 child: Consumer<Restaurant>(
// //                   builder: (context, restaurant, child) => TabBarView(
// //                     controller: _tabController,
// //                     children: getFoodInThisCategory(restaurant.foodMenu),
// //                   ),
// //                 ),
// //               ),




// //  BlocBuilder<MenuCubit, MenuState>(
// //                 builder: (context, state) {
// //                   if (state.isLoading) {
// //                     return Center(
// //                         child: CircularProgressIndicator(
// //                       color: primaryColor,
// //                     ));
// //                   } else if (state.errorMessage.isNotEmpty) {
// //                     return Center(child: Text(state.errorMessage));
// //                   } else if (state.menuList.isEmpty) {
// //                     return const Center(child: Text('No menu available'));
// //                   } else {
// //                     return SingleChildScrollView(
// //                       child: Row(
// //                         children: [
// //                           ListView.builder(
// //                             itemCount: state.menuList.length,
// //                             itemBuilder: (context, index) {
// //                               final menu = state.menuList[index];
// //                               return GestureDetector(
// //                                 onTap: () {
// //                                   _navigateToDetail(menu);
// //                                 },
// //                                 child: Container(
// //                                   decoration: BoxDecoration(
// //                                     color: Colors.grey[100],
// //                                     borderRadius: BorderRadius.circular(20),
// //                                   ),
// //                                   margin: const EdgeInsets.only(left: 25),
// //                                   padding: const EdgeInsets.all(25),
// //                                   child: Column(
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     mainAxisAlignment:
// //                                         MainAxisAlignment.spaceEvenly,
// //                                     children: [
// //                                       //IMAGE
// //                                       Image.asset(
// //                                         '${Endpoints.img}/${menu.imagePath}',
// //                                         height: 105,
// //                                       ),

// //                                       //TEXT
// //                                       Text(
// //                                         menu.name,
// //                                         style: GoogleFonts.dmSerifDisplay(
// //                                             fontSize: 20),
// //                                       ),

// //                                       //PRICE + RATING
// //                                       SizedBox(
// //                                         width: 160,
// //                                         child: Row(
// //                                           mainAxisAlignment:
// //                                               MainAxisAlignment.spaceBetween,
// //                                           children: [
// //                                             //PRICE
// //                                             Text(
// //                                               menu.price as String,
// //                                               style: TextStyle(
// //                                                 fontWeight: FontWeight.bold,
// //                                                 color: Colors.grey[700],
// //                                               ),
// //                                             ),

// //                                             //RATING
// //                                             Row(
// //                                               children: [
// //                                                 Icon(
// //                                                   Icons.star,
// //                                                   color: Colors.yellow[800],
// //                                                 ),
// //                                                 Text(
// //                                                   menu.rating as String,
// //                                                   style: const TextStyle(
// //                                                       color: Colors.grey),
// //                                                 ),
// //                                               ],
// //                                             ),
// //                                           ],
// //                                         ),
// //                                       )
// //                                     ],
// //                                   ),
// //                                 ),
// //                               );
// //                             },
// //                           ),
// //                         ],
// //                       ),
// //                     );
// //                   }
// //                 },
// //               ),

// //               SafeArea(
// //                 child: Container(
// //                   width: MediaQuery.of(context).size.width,
// //                   height: 250,
// //                   child: SingleChildScrollView(
// //                     scrollDirection: Axis.horizontal,
// //                     child: Row(
// //                       children: [
// //                         FutureBuilder<List<Menus>>(
// //                           future: _menu,
// //                           builder: (context, snapshot) {
// //                             if (snapshot.hasData) {
// //                               final menu = snapshot.data!;
// //                               return Row(
// //                                 children: List.generate(menu.length, (index) {
// //                                   final item = menu[index];
// //                                   return Container(
// //                                     width: 200,
// //                                     height: 200,
// //                                     child: ListTile(
// //                                       title: item.imagePath != null
// //                                           ? GestureDetector(
// //                                               onTap: () {_navigateToDetail(item);},
// //                                               child: Container(
// //                                                 decoration: BoxDecoration(
// //                                                   color: Colors.grey[100],
// //                                                   borderRadius:
// //                                                       BorderRadius.circular(20),
// //                                                 ),
// //                                                 margin:
// //                                                     const EdgeInsets.only(left: 25),
// //                                                 padding: const EdgeInsets.all(25),
// //                                                 child: Column(
// //                                                   crossAxisAlignment:
// //                                                       CrossAxisAlignment.start,
// //                                                   mainAxisAlignment:
// //                                                       MainAxisAlignment.spaceEvenly,
// //                                                   children: [
// //                                                     // IMAGE
// //                                                     Image.asset(
// //                                                       '${Endpoints.img}/${item.imagePath}',
// //                                                       height: 105,
// //                                                     ),

// //                                                     // TEXT
// //                                                     Text(
// //                                                       item.name,
// //                                                       style:
// //                                                           GoogleFonts.dmSerifDisplay(
// //                                                               fontSize: 20),
// //                                                     ),

// //                                                     // PRICE + RATING
// //                                                     SizedBox(
// //                                                       width: 160,
// //                                                       child: Row(
// //                                                         mainAxisAlignment:
// //                                                             MainAxisAlignment
// //                                                                 .spaceBetween,
// //                                                         children: [
// //                                                           // PRICE
// //                                                           Text(
// //                                                             "RP${item.price}",
// //                                                             style: TextStyle(
// //                                                               fontWeight:
// //                                                                   FontWeight.bold,
// //                                                               color: Colors.grey[700],
// //                                                             ),
// //                                                           ),

// //                                                           // RATING
// //                                                           Row(
// //                                                             children: [
// //                                                               Icon(
// //                                                                 Icons.star,
// //                                                                 color: Colors
// //                                                                     .yellow[800],
// //                                                               ),
// //                                                               Text(
// //                                                                 "${item.rating}",
// //                                                                 style:
// //                                                                     const TextStyle(
// //                                                                         color: Colors
// //                                                                             .grey),
// //                                                               ),
// //                                                             ],
// //                                                           ),
// //                                                         ],
// //                                                       ),
// //                                                     )
// //                                                   ],
// //                                                 ),
// //                                               ),
// //                                             )
// //                                           : null,
// //                                     ),
// //                                   );
// //                                 }),
// //                               );
// //                             } else if (snapshot.hasError) {
// //                               return Center(child: Text('${snapshot.error}'));
// //                             }
// //                             return const CircularProgressIndicator(
// //                                 color: Color.fromARGB(109, 140, 94, 91));
// //                           },
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),



//  SingleChildScrollView(
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
//                                   margin: const EdgeInsets.only(left: 25),
//                                   padding: const EdgeInsets.all(25),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       // IMAGE
//                                       Image.network(
//                                         '${Endpoints.ngrok}/${item.imagePath}',
//                                         height: 105,
//                                         fit: BoxFit.cover,
//                                         loadingBuilder: (BuildContext context,
//                                             Widget child,
//                                             ImageChunkEvent? loadingProgress) {
//                                           if (loadingProgress == null) {
//                                             return child;
//                                           } else {
//                                             return Center(
//                                               child: CircularProgressIndicator(
//                                                 value: loadingProgress
//                                                             .expectedTotalBytes !=
//                                                         null
//                                                     ? loadingProgress
//                                                             .cumulativeBytesLoaded /
//                                                         loadingProgress
//                                                             .expectedTotalBytes!
//                                                     : null,
//                                               ),
//                                             );
//                                           }
//                                         },
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
                    