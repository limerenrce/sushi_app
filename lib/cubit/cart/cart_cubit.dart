// import 'dart:io';

// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'cart_state.dart';

// class CartCubit extends Cubit<CartState> {
//   CartCubit() : super(CartInitialState());
// }

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sushi_app/models/menu.dart';
import 'package:sushi_app/models/cart_item.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.initial());

  void addItem(Menus menu, int quantity) {
    final currentState = state;
    final existingItem = currentState.cartItems.firstWhere(
      (item) => item.menu.idMenus == menu.idMenus,
      orElse: () => CartItem(menu: menu, quantity: 0),
    );

    if (existingItem.quantity > 0) {
      final updatedItems = currentState.cartItems
          .map((item) => item.menu.idMenus == menu.idMenus
              ? CartItem(menu: item.menu, quantity: item.quantity + quantity)
              : item)
          .toList();
      emit(currentState.copyWith(cartItems: updatedItems));
    } else {
      emit(currentState.copyWith(
          cartItems: List.from(currentState.cartItems)
            ..add(CartItem(menu: menu, quantity: quantity))));
    }
  }

  void removeItem(Menus menu) {
    final updatedItems = state.cartItems
        .where((item) => item.menu.idMenus != menu.idMenus)
        .toList();
    emit(state.copyWith(cartItems: updatedItems));
  }

  int calculateTotalPrice() {
    return state.cartItems.fold(
        0, (total, current) => total + (current.menu.price * current.quantity));
  }

  double getSubtotal() {
    return state.cartItems.fold(0, (total, item) => total + item.menu.price * item.quantity);
  }

  double getTax() {
    return getSubtotal() * 0.1;
  }

  double getTotal() {
    return getSubtotal() + getTax();
  }
}

