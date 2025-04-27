


import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_learning/model/product_model.dart';

abstract class FavouriteProductEvent extends Equatable {


  const FavouriteProductEvent();

  @override
  List<Object> get props => [];
}



class AddtoFavouriteEvent extends FavouriteProductEvent {
  final ProductModel productModel;
  const AddtoFavouriteEvent({required this.productModel});

  @override
  List<Object> get props => [productModel];
}