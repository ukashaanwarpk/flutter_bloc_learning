import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToCartEvent extends CartEvent {}

class RemoveFromCartEvent extends CartEvent {}

class IncrementQuantityEvent extends CartEvent {}

class DecrementQuantityEvent extends CartEvent {}
