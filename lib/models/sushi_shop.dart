import 'package:flutter/material.dart';
import 'food.dart';

class Shop extends ChangeNotifier {
  //----------SUSHI MENU----------
  final List<Food> _sushiMenu = [
    //SALMON
    Food(
        name: "Salmon Sushi",
        price: "21.000",
        imagePath: "assets/images/salmon_sushi.png",
        rating: "4.9",
        description:
            "Delicate sliced, fresh salmon drapes elegantly over a pillow of perfectly seasoned sushi rice. Its vibrant hue and buttery texture promise an exquisite melt-in-you-mouth experience. Paired with a whisper of wasabi and a side of traditional pickled ginger, oue salmon sushi is an ode to the purity and simplicity of authentic Japanese flavors. Indulge in the ocean's bounty with each savory bite.",
        category: FoodCategory.sushi),

    //TUNA
    Food(
      name: "Tuna Sushi",
      price: "23.000",
      imagePath: "assets/images/tuna_sushi.png",
      rating: "4.3",
      description:
          "Delicate sliced, fresh tuna drapes elegantly over a pillow of perfectly seasoned sushi rice. Its vibrant hue and buttery texture promise an exquisite melt-in-you-mouth experience. Paired with a whisper of wasabi and a side of traditional pickled ginger, our tuna sushi is an ode to the purity and simplicity of authentic Japanese flavors. Indulge in the ocean's bounty with each savory bite.",
      category: FoodCategory.sushi,
    ),

    //UNI
    Food(
      name: "Uni Sushi",
      price: "20.000",
      imagePath: "assets/images/tuna.png",
      rating: "4.7",
      description:
          "Delicate sliced, fresh uni drapes elegantly over a pillow of perfectly seasoned sushi rice. Its vibrant hue and buttery texture promise an exquisite melt-in-you-mouth experience. Paired with a whisper of wasabi and a side of traditional pickled ginger, our uni sushi is an ode to the purity and simplicity of authentic Japanese flavors. Indulge in the ocean's bounty with each savory bite.",
      category: FoodCategory.sushi,
    )
  ];

  //CUSTOMER CART
  List<Food> _cart = [];

  //GETTER METHODS
  List<Food> get foodMenu => _sushiMenu;
  List<Food> get cart => _cart;

  //ADD TO CART
  void addToCart(Food foodItem, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(foodItem);
    }
    notifyListeners();
  }

  //REMOVE FROM CART
  void removeFromCart(Food food) {
    _cart.remove(food);
    notifyListeners();
  }
}
