import 'package:flutter_bloc_learning/model/product_model.dart';

class CartModel {
  final int quantity;
  final ProductModel productModel;

  CartModel({required this.quantity, required this.productModel});

   CartModel copyWith({
    ProductModel? productModel,
    int? quantity,
  }) {
    return CartModel(
      productModel: productModel ?? this.productModel,
      quantity: quantity ?? this.quantity,
    );
  }
}
