import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/models/food.dart';
import 'package:sushi_app/theme/colors.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //QUANTITY COUNT
  int quantityCount = 1;

  //DECREMENT  QUANTITY
  void decrementQuantity() {
    setState(() {
      if (quantityCount > 1) {
        quantityCount--;
      }
    });
  }

  //INCREMENT QUANTITY
  void incrementQuantity() {
    setState(() {
      quantityCount++;
    });
  }

  removeFromCart(Food food, BuildContext context) {}

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
        title: const Text("My Cart"),
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: Colors.grey[300],
      ),
      body: Column(
        children: [
          //---------CUSTOMER CART---------
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: value.cart.length,
          //     itemBuilder: (context, index) {
          //       //GET FODD FROM CART
          //       final Food food = value.cart[index];

          //       //GET FOOD NAME
          //       final String foodName = food.name;

          //       //GET FOOD PRICE
          //       final String foodPrice = food.price;

          //       //RETURN LIST TITLE
          //       return Container(
          //         decoration: BoxDecoration(
          //           color: secondaryColor,
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //         margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
          //         child: Column(
          //           children: [
          //             ListTile(
          //               title: Text(
          //                 foodName,
          //                 style: const TextStyle(
          //                   color: Colors.white,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //               subtitle: Text(
          //                 foodPrice,
          //                 style: TextStyle(
          //                   color: Colors.grey[200],
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //               trailing: IconButton(
          //                 onPressed: () => removeFromCart(food, context),
          //                 icon: Icon(
          //                   Icons.delete,
          //                   color: Colors.grey[300],
          //                 ),
          //               ),
          //             ),
          //             //QUANTITY
          //             Row(
          //               children: [
          //                 //MINUS BUTTON
          //                 Container(
          //                   decoration: BoxDecoration(
          //                     color: secondaryColor,
          //                     shape: BoxShape.circle,
          //                   ),
          //                   child: IconButton(
          //                       onPressed: decrementQuantity,
          //                       icon: const Icon(
          //                         Icons.remove,
          //                         color: Colors.white,
          //                       )),
          //                 ),

          //                 //QUANTITY COUNT
          //                 SizedBox(
          //                   width: 40,
          //                   child: Center(
          //                     child: Text(
          //                       quantityCount.toString(),
          //                       style: const TextStyle(
          //                         color: Colors.white,
          //                         fontWeight: FontWeight.bold,
          //                         fontSize: 18,
          //                       ),
          //                     ),
          //                   ),
          //                 ),

          //                 //PLUS BUTTON
          //                 Container(
          //                   decoration: BoxDecoration(
          //                     color: secondaryColor,
          //                     shape: BoxShape.circle,
          //                   ),
          //                   child: IconButton(
          //                       onPressed: incrementQuantity,
          //                       icon: const Icon(
          //                         Icons.add,
          //                         color: Colors.white,
          //                       )),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // ),

          Expanded(
              child: Scaffold(
            backgroundColor: primaryColor,
            body: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              height: 150,
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
                          ),

                          //ICON ADD AND KURANG
                          Row(
                            children: [
                              IconButton(
                                  onPressed: decrementQuantity,
                                  icon: (Icon(
                                    Icons.remove_circle,
                                    color: primaryColor,
                                    size: 20,
                                  ))),
                              Text("$quantityCount"),
                              IconButton(
                                  onPressed: incrementQuantity,
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

                  //HEART
                  IconButton(
                      onPressed: () {},
                      icon: (Icon(
                        Icons.delete,
                        color: primaryColor,
                        size: 28,
                      ))),
                ],
              ),
            ),
          )),
          //---------ORDER NOW BUTTON---------
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                //SUBTOTAL
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subtotal"),
                    Text("RP 98.000"),
                  ],
                ),
                const Divider(color: Colors.grey),

                //TAX
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tax 10%"),
                    Text("RP 9.800"),
                  ],
                ),
                const Divider(color: Colors.grey),

                //TOTAL
                const Row(
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
                      "RP 107.800",
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
            ),
          ),
        ],
      ),
    );
  }
}
