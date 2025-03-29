import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_learning/utils/enum.dart';
import '../../model/product_model.dart';

class ProductState extends Equatable {
  final ProductStatus productStatus;
  final String message;
  final List<ProductModel> productsList;

  final ProductFilter productFilter;

  const ProductState(
      {this.productStatus = ProductStatus.loading,
      this.productsList = const [],
      this.message = '',
      this.productFilter = ProductFilter.sortByAToZ});

  @override
  List<Object?> get props =>
      [productStatus, productsList, message, productFilter];

  ProductState copyWith(
      {ProductStatus? productStatus,
      List<ProductModel>? productsList,
      String? message,
      ProductFilter? productFilter}) {
    return ProductState(
      productStatus: productStatus ?? this.productStatus,
      productsList: productsList ?? this.productsList,
      message: message ?? this.message,
      productFilter: productFilter ?? this.productFilter,
    );
  }
}
