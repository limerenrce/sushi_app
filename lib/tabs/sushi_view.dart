import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/components/food_tile.dart';
import 'package:sushi_app/models/sushi_shop.dart';
import 'package:sushi_app/pages/food_details_page.dart';

class SushiView extends StatefulWidget {
  const SushiView({Key? key}) : super(key: key);

  @override
  _SushiViewState createState() => _SushiViewState();
}

class _SushiViewState extends State<SushiView> {
  //NAVIGATOR
  void navigateToFoodDetails(int index) {
    //GET THE SHOP AND ITS MENU
    final shop = context.read<Shop>();
    final foodMenu = shop.foodMenu;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailsPage(
          food: foodMenu[index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //GET THE SHOP AND ITS MENU
    final shop = context.read<Shop>();
    final foodMenu = shop.foodMenu;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: foodMenu.length,
            itemBuilder: (context, index) => FoodTile(
              food: foodMenu[index],
              onTap: () => navigateToFoodDetails(index),
            ),
          )),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
