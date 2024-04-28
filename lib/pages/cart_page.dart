import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/components/button.dart';
import 'package:sushi_app/models/food.dart';
import 'package:sushi_app/models/restaurant.dart';
import 'package:sushi_app/theme/colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  //REMOVE FROM CART
  void removeFromCart(Food food, BuildContext context) {
    // GET ACCESS TO SHOP
    final restaurant = context.read<Restaurant>();

    //REMOVE FROM CART
    restaurant.removeFromCart(food);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: const Text("My Cart"),
          elevation: 0,
          backgroundColor: primaryColor,
        ),
        body: Column(
          children: [
            //---------CUSTOMER CART---------
            Expanded(
              child: ListView.builder(
                itemCount: value.cart.length,
                itemBuilder: (context, index) {
                  //GET FODD FROM CART
                  final Food food = value.cart[index];

                  //GET FOOD NAME
                  final String foodName = food.name;

                  //GET FOOD PRICE
                  final String foodPrice = food.price;

                  //RETURN LIST TITLE
                  return Container(
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: ListTile(
                      title: Text(
                        foodName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        foodPrice,
                        style: TextStyle(
                          color: Colors.grey[200],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () => removeFromCart(food, context),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            //---------PAY BUTTON---------
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: MyButton(
                text: "Pay Now",
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
