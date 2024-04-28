import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/components/button.dart';
import 'package:sushi_app/models/food.dart';
import 'package:sushi_app/models/restaurant.dart';
import 'package:sushi_app/theme/colors.dart';

class FoodDetailsPage extends StatefulWidget {
  final Food food;
  const FoodDetailsPage({super.key, required this.food});

  @override
  FoodDetailsPageState createState() => FoodDetailsPageState();
}

class FoodDetailsPageState extends State<FoodDetailsPage> {
  //QUANTITY COUNT
  int quantityCount = 0;

  //DECREMENT  QUANTITY
  void decrementQuantity() {
    setState(() {
      if (quantityCount > 0) {
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

  //ADD TO CART
  void addToCart() {
    //ONLY ADD TO CART IF THERE IS SOMETHING IN THE CART
    if (quantityCount > 0) {
      //GET ACCESS TO SHOP
      final shop = context.read<Restaurant>();

      //ADD TO CART
      shop.addToCart(widget.food, quantityCount);

      //LET THE USER KNOW IT WAS SUCCESSFUL
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: primaryColor,
          content: const Text(
            "Successfully added to cart",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          actions: [
            //OKAY BUTTON
            IconButton(
              onPressed: () {
                //POP ONCE TO REMOVE DIALOG BOX
                Navigator.pop(context);

                //POP AGAIN TO GO TO PREVIOUS SCREEN
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.done,
                color: Colors.white,
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          //LIST VIEW OF FOOD DETAILS
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView(
                children: [
                  //IMAGE
                  Image.asset(
                    widget.food.imagePath,
                    height: 200,
                  ),

                  //RATING
                  Row(
                    children: [
                      //STAR ICON
                      Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                      ),

                      const SizedBox(width: 5),

                      //RATING NUMBER
                      Text(
                        widget.food.rating,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  //FOOD NAME
                  Text(
                    widget.food.name,
                    style: GoogleFonts.dmSerifDisplay(fontSize: 28),
                  ),

                  const SizedBox(height: 25),
                  //DESCRIPTION
                  Text(
                    "Description",
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    widget.food.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      height: 2,
                    ),
                  )
                ],
              ),
            ),
          ),

          //PRICE + QUANTITY + ADD TO CART BUTTON
          Container(
            color: primaryColor,
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                //PRICE + QUANTITY
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //PRICE
                    Text(
                      "RP ${widget.food.price}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    //QUANTITY
                    Row(
                      children: [
                        //MINUS BUTTON
                        Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                              onPressed: decrementQuantity,
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              )),
                        ),

                        //QUANTITY COUNT
                        SizedBox(
                          width: 40,
                          child: Center(
                            child: Text(
                              quantityCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),

                        //PLUS BUTTON
                        Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                              onPressed: incrementQuantity,
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 25),
                //ADD TO CART BUTTON
                MyButton(text: "add To Cart ", onTap: addToCart),
              ],
            ),
          )
        ],
      ),
    );
  }
}
