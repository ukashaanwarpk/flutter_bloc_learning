import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_learning/model/product_model.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToCartEvent extends CartEvent {
  final ProductModel productModel;

  final int quantity;

  AddToCartEvent({required this.productModel, required this.quantity});

  @override
  List<Object> get props => [productModel, quantity];
}

class RemoveFromCartEvent extends CartEvent {
  final int productId;
  RemoveFromCartEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}

class IncrementQuantityEvent extends CartEvent {

  final int productId;

  IncrementQuantityEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}

class DecrementQuantityEvent extends CartEvent {

  final int productId;

  DecrementQuantityEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}
