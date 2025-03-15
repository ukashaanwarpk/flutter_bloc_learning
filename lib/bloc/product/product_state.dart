

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_learning/utils/enum.dart';
import '../../model/product_model.dart';





class ProductState extends Equatable {
  final ProductStatus productStatus;
  final String message;
  final List<ProductModel> productsList;
  

  const ProductState({ this.productStatus = ProductStatus.loading,  this.productsList = const [], this.message = ''});

  @override
  List<Object?> get props => [productStatus, productsList, message];


  ProductState copyWith({ProductStatus? productStatus, List<ProductModel>? productsList, String? message}) {
    return ProductState(
      productStatus: productStatus ?? this.productStatus, productsList: productsList ?? this.productsList,message: message ?? this.message); 
  }
}



