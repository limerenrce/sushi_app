import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/cubit/cart/cart_cubit.dart';
import 'package:sushi_app/endpoints/endpoints.dart';
import 'package:sushi_app/models/food.dart';
import 'package:sushi_app/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sushi_app/models/menu.dart';
import 'package:sushi_app/cubit/cart/cart_cubit.dart';

// import '../cubit/cart/cart_cubit.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //QUANTITY COUNT
  int quantityCount = 1;

  // int quantityCountCubit() {
  //   context.read<CartCubit>().addItem
  // }

  //DECREMENT  QUANTITY
  // void decrementQuantity() {
  //   setState(() {
  //     if (quantityCount > 1) {
  //       quantityCount--;
  //     }
  //   });
  // }
  void decrementQuantity(BuildContext context, Menus menu) {
    final cartCubit = context.read<CartCubit>();
    cartCubit.addItem(menu, -1);
    final currentItem =
        cartCubit.state.cartItems.firstWhere((item) => item.menu == menu);
    if (currentItem.quantity == 0) {
      cartCubit.removeItem(menu);
    }
  }

  //INCREMENT QUANTITY
  // void incrementQuantity() {
  //   setState(() {
  //     quantityCount++;
  //   });
  // }
  void incrementQuantity(BuildContext context, Menus menu) {
    context.read<CartCubit>().addItem(menu, 1);
  }

  //REMOVE FROM  CART
  // removeFromCart(Food food, BuildContext context) {}
  void deleteItem(BuildContext context, Menus menu) {
    context.read<CartCubit>().removeItem(menu);
  }

  //DELETE CONFIRMATION
  void showDeleteConfirmationDialog(BuildContext context, Menus menu) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          width: 350,
          height: 200,
          child: Column(
            children: [
              const SizedBox(height: 8),
              Icon(Icons.delete, color: primaryColor, size: 60),
              const SizedBox(height: 8),
              const Text(
                "Are you sure you want to remove this item from your cart?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Text(
              //   "You cannot restore the item",
              //   style: TextStyle(color: Colors.grey[800]),
              //   textAlign: TextAlign.center,
              // ),
              // Text(
              //   "once you delete it.",
              //   style: TextStyle(color: Colors.grey[800]),
              //   textAlign: TextAlign.center,
              // ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: primaryColor)),
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Cancel",
                        style: TextStyle(color: primaryColor, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  deleteItem(context, menu);
                  showDeleteSuccessDialog(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(40)),
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 20, left: 20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Delete",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }

  void showDeleteSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          width: 350,
          height: 200,
          child: Column(
            children: [
              Icon(Icons.check_circle_outline,
                  color: Colors.green[800], size: 78),
              const SizedBox(height: 15),
              const Text(
                "Removed from cart succesfully!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(40)),
              margin: const EdgeInsets.only(left: 50, right: 50),
              padding: const EdgeInsets.all(15),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ok",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void orderNow() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          width: 300,
          height: 200,
          child: Column(
            children: [
              Icon(Icons.check_circle_outline,
                  color: Colors.green[800], size: 78),
              const SizedBox(height: 8),
              const Text(
                "Your Order is Confirmed!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Your order is currently being",
                style: TextStyle(color: Colors.grey[800]),
                textAlign: TextAlign.center,
              ),
              Text(
                "prepared by our chef",
                style: TextStyle(color: Colors.grey[800]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          //OKAY BUTTON
          GestureDetector(
            onTap: () {
              //POP ONCE TO REMOVE DIALOG BOX
              Navigator.pop(context);

              //POP AGAIN TO GO TO PREVIOUS SCREEN
              // Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(40)),
              margin: const EdgeInsets.only(left: 50, right: 50),
              padding: const EdgeInsets.all(15),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //TEXT
                  Text(
                    "Ok",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text('My Cart'),
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: Colors.grey[300],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
              if (state.cartItems.isEmpty) {
                return Center(
                  child: Text('Your Cart is Empty',
                      style: TextStyle(color: Colors.white)),
                );
              } else {
                return ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = state.cartItems[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin:
                            const EdgeInsets.only(left: 20, top: 15, right: 20),
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                //IMAGE
                                Image.network(
                                  '${Endpoints.ngrok}/${cartItem.menu.imagePath}',
                                  height: 60,
                                ),

                                const SizedBox(width: 20),

                                //NAME AND PRICE
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //NAME
                                    Text(
                                      "${cartItem.menu.name}",
                                      style: GoogleFonts.dmSerifDisplay(
                                          fontSize: 18),
                                    ),

                                    const SizedBox(height: 10),

                                    //PRICE
                                    Text(
                                      'RP ${cartItem.menu.price * cartItem.quantity}',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),

                                    //ICON ADD AND KURANG
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () => decrementQuantity(
                                                context, cartItem.menu),
                                            icon: (Icon(
                                              Icons.remove_circle,
                                              color: primaryColor,
                                              size: 20,
                                            ))),
                                        Text("${cartItem.quantity}"),
                                        IconButton(
                                            onPressed: () => incrementQuantity(
                                                context, cartItem.menu),
                                            icon: (Icon(
                                              Icons.add_circle,
                                              color: primaryColor,
                                              size: 20,
                                            ))),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),

                            //delete
                            IconButton(
                                onPressed: () => showDeleteConfirmationDialog(
                                    context, cartItem.menu),
                                icon: (Icon(
                                  Icons.delete,
                                  color: primaryColor,
                                  size: 28,
                                ))),
                          ],
                        ),
                      );
                    });
              }
            }),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            padding: const EdgeInsets.all(25),
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                final cartCubit = context.read<CartCubit>();
                final subtotal = cartCubit.getSubtotal();
                final tax = cartCubit.getTax();
                final total = cartCubit.getTotal();
                
                return Column(
                  children: [
                    //SUBTOTAL
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Subtotal"),
                        Text("RP ${subtotal.toStringAsFixed(2)}"),
                      ],
                    ),
                    const Divider(color: Colors.grey),

                    //TAX
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tax 10%"),
                        Text("RP ${tax.toStringAsFixed(2)}"),
                      ],
                    ),
                    const Divider(color: Colors.grey),

                    //TOTAL
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "RP ${total.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),
                    //ORDER NOW BUTTON
                    GestureDetector(
                      onTap: orderNow,
                      child: Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(40)),
                        padding: const EdgeInsets.all(20),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //TEXT
                            Text(
                              "Order Now",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   backgroundColor: primaryColor,
    //   appBar: AppBar(
    //     title: const Text("My Cart"),
    //     elevation: 0,
    //     backgroundColor: primaryColor,
    //     foregroundColor: Colors.grey[300],
    //   ),
    //   body: Column(
    //     children: [
    //       //---------CUSTOMER CART---------
    //       // Expanded(
    //       //   child: ListView.builder(
    //       //     itemCount: value.cart.length,
    //       //     itemBuilder: (context, index) {
    //       //       //GET FODD FROM CART
    //       //       final Food food = value.cart[index];

    //       //       //GET FOOD NAME
    //       //       final String foodName = food.name;

    //       //       //GET FOOD PRICE
    //       //       final String foodPrice = food.price;

    //       //       //RETURN LIST TITLE
    //       //       return Container(
    //       //         decoration: BoxDecoration(
    //       //           color: secondaryColor,
    //       //           borderRadius: BorderRadius.circular(8),
    //       //         ),
    //       //         margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
    //       //         child: Column(
    //       //           children: [
    //       //             ListTile(
    //       //               title: Text(
    //       //                 foodName,
    //       //                 style: const TextStyle(
    //       //                   color: Colors.white,
    //       //                   fontWeight: FontWeight.bold,
    //       //                 ),
    //       //               ),
    //       //               subtitle: Text(
    //       //                 foodPrice,
    //       //                 style: TextStyle(
    //       //                   color: Colors.grey[200],
    //       //                   fontWeight: FontWeight.bold,
    //       //                 ),
    //       //               ),
    //       //               trailing: IconButton(
    //       //                 onPressed: () => removeFromCart(food, context),
    //       //                 icon: Icon(
    //       //                   Icons.delete,
    //       //                   color: Colors.grey[300],
    //       //                 ),
    //       //               ),
    //       //             ),
    //       //             //QUANTITY
    //       //             Row(
    //       //               children: [
    //       //                 //MINUS BUTTON
    //       //                 Container(
    //       //                   decoration: BoxDecoration(
    //       //                     color: secondaryColor,
    //       //                     shape: BoxShape.circle,
    //       //                   ),
    //       //                   child: IconButton(
    //       //                       onPressed: decrementQuantity,
    //       //                       icon: const Icon(
    //       //                         Icons.remove,
    //       //                         color: Colors.white,
    //       //                       )),
    //       //                 ),

    //       //                 //QUANTITY COUNT
    //       //                 SizedBox(
    //       //                   width: 40,
    //       //                   child: Center(
    //       //                     child: Text(
    //       //                       quantityCount.toString(),
    //       //                       style: const TextStyle(
    //       //                         color: Colors.white,
    //       //                         fontWeight: FontWeight.bold,
    //       //                         fontSize: 18,
    //       //                       ),
    //       //                     ),
    //       //                   ),
    //       //                 ),

    //       //                 //PLUS BUTTON
    //       //                 Container(
    //       //                   decoration: BoxDecoration(
    //       //                     color: secondaryColor,
    //       //                     shape: BoxShape.circle,
    //       //                   ),
    //       //                   child: IconButton(
    //       //                       onPressed: incrementQuantity,
    //       //                       icon: const Icon(
    //       //                         Icons.add,
    //       //                         color: Colors.white,
    //       //                       )),
    //       //                 ),
    //       //               ],
    //       //             ),
    //       //           ],
    //       //         ),
    //       //       );
    //       //     },
    //       //   ),
    //       // ),

    //       Expanded(
    //           child: Scaffold(
    //         backgroundColor: primaryColor,
    //         body: Container(
    //           decoration: BoxDecoration(
    //             color: Colors.grey[100],
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
    //           height: 150,
    //           padding: const EdgeInsets.all(20),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Row(
    //                 children: [
    //                   //IMAGE
    //                   Image.asset(
    //                     'assets/images/salmon_eggs.png',
    //                     height: 60,
    //                   ),

    //                   const SizedBox(width: 20),

    //                   //NAME AND PRICE
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       //NAME
    //                       Text(
    //                         "Salmon Eggs",
    //                         style: GoogleFonts.dmSerifDisplay(fontSize: 18),
    //                       ),

    //                       const SizedBox(height: 10),

    //                       //PRICE
    //                       Text(
    //                         'RP 21.000',
    //                         style: TextStyle(color: Colors.grey[700]),
    //                       ),

    //                       //ICON ADD AND KURANG
    //                       Row(
    //                         children: [
    //                           IconButton(
    //                               onPressed: decrementQuantity,
    //                               icon: (Icon(
    //                                 Icons.remove_circle,
    //                                 color: primaryColor,
    //                                 size: 20,
    //                               ))),
    //                           Text("$quantityCount"),
    //                           IconButton(
    //                               onPressed: incrementQuantity,
    //                               icon: (Icon(
    //                                 Icons.add_circle,
    //                                 color: primaryColor,
    //                                 size: 20,
    //                               ))),
    //                         ],
    //                       )
    //                     ],
    //                   ),
    //                 ],
    //               ),

    //               //HEART
    //               IconButton(
    //                   onPressed: () {},
    //                   icon: (Icon(
    //                     Icons.delete,
    //                     color: primaryColor,
    //                     size: 28,
    //                   ))),
    //             ],
    //           ),
    //         ),
    //       )),
    //       //---------ORDER NOW BUTTON---------
    //       Container(
    //         decoration: const BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(20),
    //                 topRight: Radius.circular(20))),
    //         padding: const EdgeInsets.all(25),
    //         child: Column(
    //           children: [
    //             //SUBTOTAL
    //             const Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Text("Subtotal"),
    //                 Text("RP 98.000"),
    //               ],
    //             ),
    //             const Divider(color: Colors.grey),

    //             //TAX
    //             const Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Text("Tax 10%"),
    //                 Text("RP 9.800"),
    //               ],
    //             ),
    //             const Divider(color: Colors.grey),

    //             //TOTAL
    //             const Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Text(
    //                   "Total",
    //                   style: TextStyle(
    //                     color: Colors.black,
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 18,
    //                   ),
    //                 ),
    //                 Text(
    //                   "RP 107.800",
    //                   style: TextStyle(
    //                     color: Colors.black,
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 18,
    //                   ),
    //                 ),
    //               ],
    //             ),

    //             const SizedBox(height: 25),
    //             //ORDER NOW BUTTON
    //             GestureDetector(
    //               onTap: orderNow,
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                     color: primaryColor,
    //                     borderRadius: BorderRadius.circular(40)),
    //                 padding: const EdgeInsets.all(20),
    //                 child: const Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     //TEXT
    //                     Text(
    //                       "Order Now",
    //                       style: TextStyle(color: Colors.white),
    //                     ),
    //                     SizedBox(height: 10),
    //                   ],
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
