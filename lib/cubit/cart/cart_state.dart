// part of 'cart_cubit.dart';

// @immutable
// sealed class CartState {}

// final class CartInitial extends CartState {}

part of 'cart_cubit.dart';

class CartState extends Equatable {
  final List<CartItem> cartItems;
  final int notificationCount;

  const CartState({required this.cartItems, required this.notificationCount});

  factory CartState.initial() {
    return const CartState(cartItems: [], notificationCount: 0);
  }

  CartState copyWith({List<CartItem>? cartItems, int? notificationCount}) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      notificationCount: notificationCount ?? this.notificationCount,
    );
  }

  @override
  List<Object> get props => [cartItems, notificationCount];
}
