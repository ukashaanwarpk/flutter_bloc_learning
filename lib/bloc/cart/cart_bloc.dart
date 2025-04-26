import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_learning/bloc/cart/cart_event.dart';
import 'package:flutter_bloc_learning/bloc/cart/cart_state.dart';
import 'package:flutter_bloc_learning/model/cart_model.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartModel> _cartItems = [];
  CartBloc() : super(const CartState()) {
    on<AddToCartEvent>(_addToCart);
    on<RemoveFromCartEvent>(_removeFromCart);
    on<IncrementQuantityEvent>(_incrementQuantity);
    on<DecrementQuantityEvent>(_decrementQuantity);
  }

  void _addToCart(AddToCartEvent event, Emitter<CartState> emit) {
    final index = state.cartItems.indexWhere((element) => element.productModel.id == event.productModel.id);

    if (index == -1) {
      _cartItems.add(CartModel(quantity: 1, productModel: event.productModel));
    } else {
      final existing = _cartItems[index];
      _cartItems[index] = existing.copyWith(
        quantity: existing.quantity + event.quantity,
      );
    }
    emit(state.copyWith(cartItems: List.from(_cartItems)));
  }

  void _removeFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    _cartItems.removeWhere((element) => element.productModel.id == event.productId);
    emit(state.copyWith(cartItems: List.from(_cartItems)));
  }

  void _incrementQuantity(IncrementQuantityEvent event, Emitter<CartState> emit) {
    final index = state.cartItems.indexWhere((element) => element.productModel.id == event.productId);

    if (index != -1) {
      final existing = _cartItems[index];
      _cartItems[index] = existing.copyWith(quantity: existing.quantity + 1);
      emit(state.copyWith(cartItems: List.from(_cartItems)));
    }
  }

  void _decrementQuantity(DecrementQuantityEvent event, Emitter<CartState> emit) {
    final index = state.cartItems.indexWhere((element) => element.productModel.id == event.productId);

    if (index != -1) {
      final existing = _cartItems[index];
      if (state.cartItems[index].quantity > 1) {
        _cartItems[index] = existing.copyWith(quantity: existing.quantity - 1);
      }
      emit(state.copyWith(cartItems: List.from(_cartItems)));
    }
  }

  double get subTotal {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.productModel.price! * item.quantity;
    }
    return total;
  }

  double get cartTotal {
    double total = 0.0;

    total = subTotal + 10.0;

    return total;
  }

  
}
