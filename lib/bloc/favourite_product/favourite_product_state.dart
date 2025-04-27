import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_learning/model/product_model.dart';

class FavouriteProductState extends Equatable {
  final List<ProductModel> favouriteProductList;
  const FavouriteProductState({this.favouriteProductList = const [],  });

  @override
  List<Object?> get props => [favouriteProductList, ];


  FavouriteProductState copyWith({
    List<ProductModel>? favouriteProductList,
  
    
  }) {
    return FavouriteProductState(
      favouriteProductList: favouriteProductList ?? this.favouriteProductList,
     
    );
  }
}
