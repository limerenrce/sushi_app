import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/cubit/cart/cart_cubit.dart';
import 'package:sushi_app/cubit/profile/profile_cubit.dart';
import 'package:sushi_app/endpoints/endpoints.dart';
import 'package:sushi_app/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sushi_app/models/menu.dart';
import 'package:sushi_app/services/data_service.dart';
import 'package:sushi_app/utils/secure_storage_util.dart'; // Import your DataService

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // final DataService _dataService = DataService.;

  //QUANTITY COUNT
  int quantityCount = 1;
  void decrementQuantity(BuildContext context, Menus menu) {
    final cartCubit = context.read<CartCubit>();
    cartCubit.addItem(menu, -1);
    final currentItem =
        cartCubit.state.cartItems.firstWhere((item) => item.menu == menu);
    if (currentItem.quantity == 0) {
      cartCubit.removeItem(menu);
    }
  }

  void incrementQuantity(BuildContext context, Menus menu) {
    context.read<CartCubit>().addItem(menu, 1);
  }

  //REMOVE FROM CART
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
                "Removed from cart successfully!",
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

  void orderNow(BuildContext context) async {
  final cartCubit = context.read<CartCubit>();
  final cartItems = cartCubit.state.cartItems;

  // Access the username from ProfileCubit
  final profileCubit = context.read<ProfileCubit>();
  final username = profileCubit.state.userLogged;

  // Prepare data for ordering
  final idMenus = cartItems.map((item) => item.menu.idMenus).toList();
  final quantities = cartItems.map((item) => item.quantity).toList();
  final totals = cartItems.map((item) => item.menu.price * item.quantity).toList();

  // Log the request details
  print('Order Request:');
  print('Username: $username');
  print('ID Menus: $idMenus');
  print('Quantities: $quantities');
  print('Totals: $totals');

  try {
    // Send order data to API
    final response = await DataService().createOrder(username, idMenus, quantities, totals);

    // Log the response details
    print('Order Response: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 201) {
      // Show success dialog or handle success state
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
                Icon(Icons.check_circle_outline, color: Colors.green[800], size: 78),
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

      // Clear cart after successful order
      cartCubit.clearCart();
    } else {
      throw Exception('Failed to place order: ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    // Handle error if order fails
    print('Order Error: $e');

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
              Icon(Icons.error_outline, color: Colors.red[800], size: 78),
              const SizedBox(height: 8),
              const Text(
                "Order Failed!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Failed to place order. Please try again.",
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
                // final tax = cartCubit.getTax();
                // final total = cartCubit.getTotal();

                return Column(
                  children: [
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
                          "RP ${subtotal}",
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
                      onTap: () => orderNow(context), // Pass context to orderNow
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
  }
}


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sushi_app/cubit/cart/cart_cubit.dart';
// import 'package:sushi_app/endpoints/endpoints.dart';
// import 'package:sushi_app/theme/colors.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sushi_app/models/menu.dart';


// class CartPage extends StatefulWidget {
//   const CartPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _CartPageState createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
  
//   //QUANTITY COUNT
//   int quantityCount = 1;
//   void decrementQuantity(BuildContext context, Menus menu) {
//     final cartCubit = context.read<CartCubit>();
//     cartCubit.addItem(menu, -1);
//     final currentItem =
//         cartCubit.state.cartItems.firstWhere((item) => item.menu == menu);
//     if (currentItem.quantity == 0) {
//       cartCubit.removeItem(menu);
//     }
//   }

//   void incrementQuantity(BuildContext context, Menus menu) {
//     context.read<CartCubit>().addItem(menu, 1);
//   }

//   //REMOVE FROM  CART
//   void deleteItem(BuildContext context, Menus menu) {
//     context.read<CartCubit>().removeItem(menu);
//   }

//   //DELETE CONFIRMATION
//   void showDeleteConfirmationDialog(BuildContext context, Menus menu) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         backgroundColor: Colors.white,
//         content: SizedBox(
//           width: 350,
//           height: 200,
//           child: Column(
//             children: [
//               const SizedBox(height: 8),
//               Icon(Icons.delete, color: primaryColor, size: 60),
//               const SizedBox(height: 8),
//               const Text(
//                 "Are you sure you want to remove this item from your cart?",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//             ],
//           ),
//         ),
//         actions: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const SizedBox(width: 8),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(40),
//                       border: Border.all(color: primaryColor)),
//                   padding: const EdgeInsets.only(
//                       top: 8, bottom: 8, right: 20, left: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Cancel",
//                         style: TextStyle(color: primaryColor, fontSize: 18),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                   deleteItem(context, menu);
//                   showDeleteSuccessDialog(context);
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: primaryColor,
//                       borderRadius: BorderRadius.circular(40)),
//                   padding: const EdgeInsets.only(
//                       top: 8, bottom: 8, right: 20, left: 20),
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Delete",
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void showDeleteSuccessDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         backgroundColor: Colors.white,
//         content: SizedBox(
//           width: 350,
//           height: 200,
//           child: Column(
//             children: [
//               Icon(Icons.check_circle_outline,
//                   color: Colors.green[800], size: 78),
//               const SizedBox(height: 15),
//               const Text(
//                 "Removed from cart succesfully!",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                   color: primaryColor, borderRadius: BorderRadius.circular(40)),
//               margin: const EdgeInsets.only(left: 50, right: 50),
//               padding: const EdgeInsets.all(15),
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Ok",
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                   SizedBox(height: 10),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void orderNow() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         backgroundColor: Colors.white,
//         content: SizedBox(
//           width: 300,
//           height: 200,
//           child: Column(
//             children: [
//               Icon(Icons.check_circle_outline,
//                   color: Colors.green[800], size: 78),
//               const SizedBox(height: 8),
//               const Text(
//                 "Your Order is Confirmed!",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 23,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 "Your order is currently being",
//                 style: TextStyle(color: Colors.grey[800]),
//                 textAlign: TextAlign.center,
//               ),
//               Text(
//                 "prepared by our chef",
//                 style: TextStyle(color: Colors.grey[800]),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           //OKAY BUTTON
//           GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                   color: primaryColor, borderRadius: BorderRadius.circular(40)),
//               margin: const EdgeInsets.only(left: 50, right: 50),
//               padding: const EdgeInsets.all(15),
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   //TEXT
//                   Text(
//                     "Ok",
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                   SizedBox(height: 10),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       appBar: AppBar(
//         title: Text('My Cart'),
//         elevation: 0,
//         backgroundColor: primaryColor,
//         foregroundColor: Colors.grey[300],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
//               if (state.cartItems.isEmpty) {
//                 return Center(
//                   child: Text('Your Cart is Empty',
//                       style: TextStyle(color: Colors.white)),
//                 );
//               } else {
//                 return ListView.builder(
//                     itemCount: state.cartItems.length,
//                     itemBuilder: (context, index) {
//                       final cartItem = state.cartItems[index];
//                       return Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey[100],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         margin:
//                             const EdgeInsets.only(left: 20, top: 15, right: 20),
//                         padding: const EdgeInsets.all(15),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 //IMAGE
//                                 Image.network(
//                                   '${Endpoints.ngrok}/${cartItem.menu.imagePath}',
//                                   height: 60,
//                                 ),

//                                 const SizedBox(width: 20),

//                                 //NAME AND PRICE
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     //NAME
//                                     Text(
//                                       "${cartItem.menu.name}",
//                                       style: GoogleFonts.dmSerifDisplay(
//                                           fontSize: 18),
//                                     ),

//                                     const SizedBox(height: 10),

//                                     //PRICE
//                                     Text(
//                                       'RP ${cartItem.menu.price * cartItem.quantity}',
//                                       style: TextStyle(color: Colors.grey[700]),
//                                     ),

//                                     //ICON ADD AND KURANG
//                                     Row(
//                                       children: [
//                                         IconButton(
//                                             onPressed: () => decrementQuantity(
//                                                 context, cartItem.menu),
//                                             icon: (Icon(
//                                               Icons.remove_circle,
//                                               color: primaryColor,
//                                               size: 20,
//                                             ))),
//                                         Text("${cartItem.quantity}"),
//                                         IconButton(
//                                             onPressed: () => incrementQuantity(
//                                                 context, cartItem.menu),
//                                             icon: (Icon(
//                                               Icons.add_circle,
//                                               color: primaryColor,
//                                               size: 20,
//                                             ))),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),

//                             //delete
//                             IconButton(
//                                 onPressed: () => showDeleteConfirmationDialog(
//                                     context, cartItem.menu),
//                                 icon: (Icon(
//                                   Icons.delete,
//                                   color: primaryColor,
//                                   size: 28,
//                                 ))),
//                           ],
//                         ),
//                       );
//                     });
//               }
//             }),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20))),
//             padding: const EdgeInsets.all(25),
//             child: BlocBuilder<CartCubit, CartState>(
//               builder: (context, state) {
//                 final cartCubit = context.read<CartCubit>();
//                 final subtotal = cartCubit.getSubtotal();
//                 // final tax = cartCubit.getTax();
//                 // final total = cartCubit.getTotal();
                
//                 return Column(
//                   children: [
//                     //SUBTOTAL
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //   children: [
//                     //     Text("Subtotal"),
//                     //     Text("RP ${subtotal.toStringAsFixed(2)}"),
//                     //   ],
//                     // ),
//                     // const Divider(color: Colors.grey),

//                     //TAX
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //   children: [
//                     //     Text("Tax 10%"),
//                     //     Text("RP ${tax.toStringAsFixed(2)}"),
//                     //   ],
//                     // ),
//                     // const Divider(color: Colors.grey),

//                     //TOTAL
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Total",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         ),
//                         Text(
//                           "RP ${subtotal}",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 25),
//                     //ORDER NOW BUTTON
//                     GestureDetector(
//                       onTap: orderNow,
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: primaryColor,
//                             borderRadius: BorderRadius.circular(40)),
//                         padding: const EdgeInsets.all(20),
//                         child: const Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             //TEXT
//                             Text(
//                               "Order Now",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             SizedBox(height: 10),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
