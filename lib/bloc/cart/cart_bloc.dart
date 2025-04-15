import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_learning/bloc/cart/cart_event.dart';
import 'package:flutter_bloc_learning/bloc/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCartEvent>(_addToCart);
    on<RemoveFromCartEvent>(_removeFromCart);
    on<IncrementQuantityEvent>(_incrementQuantity);
    on<DecrementQuantityEvent>(_decrementQuantity);
  }

  void _addToCart(AddToCartEvent event, Emitter<CartState> emit) {}
  void _removeFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {}
  void _incrementQuantity(IncrementQuantityEvent event, Emitter<CartState> emit) {}
  void _decrementQuantity(DecrementQuantityEvent event, Emitter<CartState> emit) {}
}
