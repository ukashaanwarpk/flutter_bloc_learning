import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_learning/utils/enum.dart';
import '../../model/product_model.dart';


class ProductState extends Equatable {
  final ProductStatus productStatus;
  final String message;
  final List<ProductModel> productsList;
  final List<ProductModel> filterProductsList;
  final double productMinPrice; // Min price in the product data
  final double productMaxPrice; // Max price in the product data
  final double selectedMinPrice; // User's selected min price
  final double selectedMaxPrice; // User's selected max price

  final ProductFilter productFilter;

  const ProductState({
    this.productStatus = ProductStatus.loading,
    this.productsList = const [],
    this.filterProductsList = const [],
    this.message = '',
    this.productFilter = ProductFilter.sortByAToZ,
    this.productMinPrice = 0.0,
    this.productMaxPrice = 0.0,
    this.selectedMinPrice = 0.0,
    this.selectedMaxPrice = 0.0,
  });

  @override
  List<Object?> get props => [
        productStatus,
        productsList,
        message,
        productFilter,
        productMinPrice,
        productMaxPrice,
        selectedMinPrice,
        selectedMaxPrice,
        filterProductsList,
      ];

  ProductState copyWith({
    ProductStatus? productStatus,
    List<ProductModel>? productsList,
    String? message,
    ProductFilter? productFilter,
    double? productMinPrice,
    double? productMaxPrice,
    double? selectedMinPrice,
    double? selectedMaxPrice,
    List<ProductModel>? filterProductsList,
  }) {
    return ProductState(
      productStatus: productStatus ?? this.productStatus,
      productsList: productsList ?? this.productsList,
      message: message ?? this.message,
      productFilter: productFilter ?? this.productFilter,
      productMinPrice: productMinPrice ?? this.productMinPrice,
      productMaxPrice: productMaxPrice ?? this.productMaxPrice,
      selectedMinPrice: selectedMinPrice ?? this.selectedMinPrice,
      selectedMaxPrice: selectedMaxPrice ?? this.selectedMaxPrice,
      filterProductsList: filterProductsList ?? this.filterProductsList,
    );
  }
}
