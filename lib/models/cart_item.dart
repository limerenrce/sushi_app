// import 'package:sushi_app/models/food.dart';

// class CartItem {
//   Food food;
//   int quantity;

//   CartItem({
//     required this.food,
//     this.quantity = 1,
//   });

//   String get totalPrice {
//     return food.price * quantity;
//   }
// }

import 'package:equatable/equatable.dart';
import 'package:sushi_app/models/menu.dart';

class CartItem extends Equatable {
  final Menus menu;
  final int quantity;

  CartItem({required this.menu, required this.quantity});

  @override
  List<Object> get props => [menu, quantity];
}
