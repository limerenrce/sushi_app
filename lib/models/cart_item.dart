import 'package:sushi_app/models/food.dart';

class CartItem {
  Food food;
  int quantity;

  CartItem({
    required this.food,
    this.quantity = 1,
  });

  String get totalPrice {
    return food.price * quantity;
  }
}
