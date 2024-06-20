// part of 'cart_cubit.dart';

// @immutable
// sealed class CartState {}

// final class CartInitial extends CartState {}

part of 'cart_cubit.dart';

class CartState extends Equatable {
  final List<CartItem> cartItems;

  const CartState({required this.cartItems});

  factory CartState.initial() {
    return CartState(cartItems: []);
  }

  CartState copyWith({List<CartItem>? cartItems}) {
    return CartState(cartItems: cartItems ?? this.cartItems);
  }

  @override
  List<Object> get props => [cartItems];
}
