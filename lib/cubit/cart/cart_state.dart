part of 'cart_cubit.dart';

class CartState extends Equatable {
  final List<CartItem> cartItems;
  final int notificationCount;

  CartState({required this.cartItems, required this.notificationCount});

  factory CartState.initial() {
    return CartState(cartItems: [], notificationCount: 0);
  }

  CartState copyWith({List<CartItem>? cartItems}) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      notificationCount: _calculateTotalQuantity(cartItems ?? this.cartItems),
    );
  }

  @override
  List<Object> get props => [cartItems, notificationCount];

  static int _calculateTotalQuantity(List<CartItem> cartItems) {
    return cartItems.fold(0, (total, item) => total + item.quantity);
  }
}
