import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_learning/bloc/cart/cart_event.dart';
import 'package:flutter_bloc_learning/bloc/cart/cart_state.dart';
import 'package:flutter_bloc_learning/model/cart_model.dart';
import 'package:flutter_bloc_learning/utils/local_storage.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartModel> _cartItems = [];
  CartBloc() : super(const CartState()) {
    on<AddToCartEvent>(_addToCart);
    on<RemoveFromCartEvent>(_removeFromCart);
    on<IncrementQuantityEvent>(_incrementQuantity);
    on<DecrementQuantityEvent>(_decrementQuantity);
    on<LoadItemFromStorageEvent>(_loadItemFromStorage);
    add(LoadItemFromStorageEvent());
  }

  void _loadItemFromStorage(LoadItemFromStorageEvent event, Emitter<CartState> emit) async {
    final data = await TLocalStorage.getData('cart_items');
    if (data != null) {
      _cartItems
        ..clear()
        ..addAll((data as List).cast<CartModel>());
      emit(state.copyWith(
        cartItems: List.from(_cartItems),
      ));
    }
  }

  void _addToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    final index = state.cartItems.indexWhere((element) => element.productModel.id == event.productModel.id);

    if (index == -1) {
      _cartItems.add(CartModel(quantity: 1, productModel: event.productModel));
    } else {
      final existing = _cartItems[index]; // grab old
      _cartItems[index] = existing.copyWith(
        // replace with new
        quantity: existing.quantity + event.quantity,
      );
    }

    final success = await TLocalStorage.saveData('cart_items', _cartItems);
    debugPrint(success ? 'Saved cart items' : 'Failed to save cart items');

    emit(state.copyWith(cartItems: List.from(_cartItems)));
  }

  void _removeFromCart(RemoveFromCartEvent event, Emitter<CartState> emit)async {
    _cartItems.removeWhere((element) => element.productModel.id == event.productId);

    await TLocalStorage.saveData('cart_items', _cartItems);


    emit(state.copyWith(cartItems: List.from(_cartItems)));
  }

  void _incrementQuantity(IncrementQuantityEvent event, Emitter<CartState> emit)async {
    final index = state.cartItems.indexWhere((element) => element.productModel.id == event.productId);

    if (index != -1) {
      final existing = _cartItems[index];
      _cartItems[index] = existing.copyWith(quantity: existing.quantity + 1);
      await TLocalStorage.saveData('cart_items', _cartItems);


      emit(state.copyWith(cartItems: List.from(_cartItems)));
    }
  }

  void _decrementQuantity(DecrementQuantityEvent event, Emitter<CartState> emit)async {
    final index = state.cartItems.indexWhere((element) => element.productModel.id == event.productId);

    if (index != -1) {
      final existing = _cartItems[index];
      if (state.cartItems[index].quantity > 1) {
        _cartItems[index] = existing.copyWith(quantity: existing.quantity - 1);
      }
      await TLocalStorage.saveData('cart_items', _cartItems);
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
