import 'package:flutter/material.dart';
import 'package:sushi_app/models/cart_item.dart';

import 'food.dart';

class Restaurant extends ChangeNotifier {
  final List<Food> _menu = [
    //SUSHI
    Food(
      name: "Tuna Sushi",
      price: "23.000",
      imagePath: "assets/images/tuna_sushi.png",
      rating: "4.3",
      description:
          "Delicate sliced, fresh tuna drapes elegantly over a pillow of perfectly seasoned sushi rice. Its vibrant hue and buttery texture promise an exquisite melt-in-you-mouth experience. Paired with a whisper of wasabi and a side of traditional pickled ginger, our tuna sushi is an ode to the purity and simplicity of authentic Japanese flavors. Indulge in the ocean's bounty with each savory bite.",
      category: FoodCategory.sushi,
    ),
    Food(
      name: "Salmon Sushi",
      price: "21.000",
      imagePath: "assets/images/salmon_sushi.png",
      rating: "4.9",
      description:
          "Delicate sliced, fresh salmon drapes elegantly over a pillow of perfectly seasoned sushi rice. Its vibrant hue and buttery texture promise an exquisite melt-in-you-mouth experience. Paired with a whisper of wasabi and a side of traditional pickled ginger, oue salmon sushi is an ode to the purity and simplicity of authentic Japanese flavors. Indulge in the ocean's bounty with each savory bite.",
      category: FoodCategory.sushi,
    ),
    Food(
      name: "Uni Sushi",
      price: "20.000",
      imagePath: "assets/images/tuna.png",
      rating: "4.7",
      description:
          "Delicate sliced, fresh uni drapes elegantly over a pillow of perfectly seasoned sushi rice. Its vibrant hue and buttery texture promise an exquisite melt-in-you-mouth experience. Paired with a whisper of wasabi and a side of traditional pickled ginger, our uni sushi is an ode to the purity and simplicity of authentic Japanese flavors. Indulge in the ocean's bounty with each savory bite.",
      category: FoodCategory.sushi,
    ),
    Food(
      name: "Salmon Eggs",
      price: "21.000",
      imagePath: "assets/images/salmon_eggs.png",
      rating: "4.7",
      description:
          "Delicate sliced, fresh salmon eggs drapes elegantly over a pillow of perfectly seasoned sushi rice. Its vibrant hue and buttery texture promise an exquisite melt-in-you-mouth experience. Paired with a whisper of wasabi and a side of traditional pickled ginger, our salmon eggs is an ode to the purity and simplicity of authentic Japanese flavors. Indulge in the ocean's bounty with each savory bite.",
      category: FoodCategory.sushi,
    ),

    //RAMEN
    Food(
      name: "Tori Ramen",
      price: "30.000",
      imagePath: "assets/images/ramen_tori.png",
      rating: "4.7",
      description: "Tori Ramen enak loh",
      category: FoodCategory.ramen,
    ),
    Food(
      name: "Charsiu Ramen",
      price: "33.000",
      imagePath: "assets/images/ramen_charsiu.png",
      rating: "4.9",
      description: "Charsiu Ramen enak loh",
      category: FoodCategory.ramen,
    ),

    //DRINK
    Food(
      name: "Orange Juice",
      price: "10.000",
      imagePath: "assets/images/orange_juice.png",
      rating: "4",
      description: "Orange juice segar",
      category: FoodCategory.drink,
    ),
  ];

  /*


    G E T T E R S


  */
  List<Food> get foodMenu => _menu;

  /*


    O P E R A T I O N S 


  */
  //USER CART

  final List<CartItem> _cart = [];
  //ADD TO CART
  void addToCart(Food foodItem, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(foodItem as CartItem);
    }
    notifyListeners();
  }
  // List<Food> get cart => _cart;

  //REMOVE FROM CART
  void removeFromCart(Food food) {
    _cart.remove(food);
    notifyListeners();
  }

  //GET TOTAL PRICE OF THE CART

  //GET TOTAL NUMBER OF ITEMS IN CART

  //CLEAR CART

  /*


    H E L P E R S 


  */
  //GENERATE A RECEIPT

  //FORMAT DOUBLE VALUE INTO MONEY

  //FORMAT LIST OF ADDONS INTO A STRING SUMMARY
}
