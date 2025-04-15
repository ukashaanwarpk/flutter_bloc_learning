import 'package:flutter_bloc_learning/model/product_model.dart';

class CartModel {
  final int quantity;
  final ProductModel productModel;

  CartModel({required this.quantity, required this.productModel});
}
