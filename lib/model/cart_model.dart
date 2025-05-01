import 'package:flutter_bloc_learning/model/product_model.dart';
import 'package:hive/hive.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 2)
class CartModel {
  @HiveField(0)
  final int quantity;
  @HiveField(1)
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

  toJson() {
    return {
      'quantity': quantity,
      'productModel': productModel.toJson(),
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      quantity: json['quantity'],
      productModel: ProductModel.fromJson(json['productModel']),
    );
  }
}
