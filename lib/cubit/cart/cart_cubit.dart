// import 'dart:io';

// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'cart_state.dart';

// class CartCubit extends Cubit<CartState> {
//   CartCubit() : super(CartInitialState());
// }

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sushi_app/models/menu.dart';
import 'package:sushi_app/models/cart_item.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.initial());

  // //ADD ITEM
  // void addItem(Menus menu, int quantity) {
  //   final currentState = state;
  //   final existingItem = currentState.cartItems.firstWhere(
  //     (item) => item.menu.idMenus == menu.idMenus,
  //     orElse: () => CartItem(menu: menu, quantity: 0),
  //   );

  //   if (existingItem.quantity > 0) {
  //     final updatedItems = currentState.cartItems
  //         .map((item) => item.menu.idMenus == menu.idMenus
  //             ? CartItem(menu: item.menu, quantity: item.quantity + quantity)
  //             : item)
  //         .toList();
  //     emit(currentState.copyWith(cartItems: updatedItems));
  //   } else {
  //     emit(currentState.copyWith(
  //         cartItems: List.from(currentState.cartItems)
  //           ..add(CartItem(menu: menu, quantity: quantity))));
  //   }
  // }

  //ADD ITEM
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
      emit(currentState.copyWith(
          cartItems: updatedItems,
          notificationCount: currentState.notificationCount + 1));
    } else {
      emit(currentState.copyWith(
          cartItems: List.from(currentState.cartItems)
            ..add(CartItem(menu: menu, quantity: quantity)),
          notificationCount: currentState.notificationCount + 1));
    }
  }

  //RESET NOTIFICATION COUNT
  void resetNotificationCount() {
    emit(state.copyWith(notificationCount: 0));
  }

  //REMOVE ITEM
  void removeItem(Menus menu) {
    final updatedItems = state.cartItems
        .where((item) => item.menu.idMenus != menu.idMenus)
        .toList();
    emit(state.copyWith(cartItems: updatedItems));
  }

  //GET TOTAL FOR 1 ITEM IN DETAIL
  int calculateTotalPrice() {
    return state.cartItems.fold(
        0, (total, current) => total + (current.menu.price * current.quantity));
  }

  //GET SUBTOTAL
  double getSubtotal() {
    return state.cartItems
        .fold(0, (total, item) => total + item.menu.price * item.quantity);
  }

  //GET TAX
  double getTax() {
    return getSubtotal() * 0.1;
  }

  //GET TOTAL ORDER
  double getTotal() {
    return getSubtotal() + getTax();
  }
}
