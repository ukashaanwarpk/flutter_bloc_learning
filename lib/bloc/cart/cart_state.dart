import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_learning/model/cart_model.dart';

class CartState extends Equatable {
  final List<CartModel> cartItems;

  const CartState({
    this.cartItems = const [],
  });

  @override
  List<Object> get props => [
        cartItems,
      ];

  CartState copyWith({List<CartModel>? cartItems, int? quantity}) => CartState(
        cartItems: cartItems ?? this.cartItems,
      );
}
