import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/components/user_drawer.dart';
import 'package:sushi_app/models/menu.dart';
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
  // //TABS
  // late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _menu = DataService.getMenu();
    // // _tabController =
    // TabController(length: FoodCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    // _tabController.dispose();
    super.dispose();
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

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // FutureBuilder<List<Menus>>(
                    //   future: _menu,
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasData) {
                    //       final menu = snapshot.data!;
                    //       return ListView.builder(
                    //           itemCount: menu.length,
                    //           itemBuilder: (context, index) {
                    //             final item = menu[index];
                    //             return ListTile(
                    //               title: item.imagePath != null
                    //                   ? GestureDetector(
                    //                       onTap: () {},
                    //                       child: Container(
                    //                         decoration: BoxDecoration(
                    //                           color: Colors.grey[100],
                    //                           borderRadius:
                    //                               BorderRadius.circular(20),
                    //                         ),
                    //                         margin:
                    //                             const EdgeInsets.only(left: 25),
                    //                         padding: const EdgeInsets.all(25),
                    //                         child: Column(
                    //                           crossAxisAlignment:
                    //                               CrossAxisAlignment.start,
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment.spaceEvenly,
                    //                           children: [
                    //                             //IMAGE
                    //                             Image.asset(
                    //                               '${Endpoints.img}/${item.imagePath}',
                    //                               height: 105,
                    //                             ),

                    //                             //TEXT
                    //                             Text(
                    //                               item.name,
                    //                               style: GoogleFonts
                    //                                   .dmSerifDisplay(
                    //                                       fontSize: 20),
                    //                             ),

                    //                             //PRICE + RATING
                    //                             SizedBox(
                    //                               width: 160,
                    //                               child: Row(
                    //                                 mainAxisAlignment:
                    //                                     MainAxisAlignment
                    //                                         .spaceBetween,
                    //                                 children: [
                    //                                   //PRICE
                    //                                   Text(
                    //                                     item.price as String,
                    //                                     style: TextStyle(
                    //                                       fontWeight:
                    //                                           FontWeight.bold,
                    //                                       color:
                    //                                           Colors.grey[700],
                    //                                     ),
                    //                                   ),

                    //                                   //RATING
                    //                                   Row(
                    //                                     children: [
                    //                                       Icon(
                    //                                         Icons.star,
                    //                                         color: Colors
                    //                                             .yellow[800],
                    //                                       ),
                    //                                       Text(
                    //                                         item.rating
                    //                                             as String,
                    //                                         style:
                    //                                             const TextStyle(
                    //                                                 color: Colors
                    //                                                     .grey),
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             )
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     )
                    //                   : null,
                    //             );
                    //           });
                    //     } else if (snapshot.hasError) {
                    //       return Center(child: Text('${snapshot.error}'));
                    //     }
                    //     return const CircularProgressIndicator(
                    //         color: Color.fromARGB(109, 140, 94, 91));
                    //   },
                    //  ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.only(left: 25),
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //IMAGE
                            Image.asset(
                              'assets/images/salmon_sushi.png',
                              height: 105,
                            ),

                            //TEXT
                            Text(
                              "Salmon Sushi",
                              style: GoogleFonts.dmSerifDisplay(fontSize: 20),
                            ),

                            //PRICE + RATING
                            SizedBox(
                              width: 160,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //PRICE
                                  Text(
                                    'RP 20.000',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                  ),

                                  //RATING
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow[800],
                                      ),
                                      Text(
                                        '4.3',
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

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
