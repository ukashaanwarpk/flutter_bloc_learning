import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_learning/bloc/favourite_product/favourite_product_event.dart';
import 'package:flutter_bloc_learning/bloc/favourite_product/favourite_product_state.dart';
import 'package:flutter_bloc_learning/model/product_model.dart';

class FavouriteProductBloc extends Bloc<FavouriteProductEvent, FavouriteProductState> {
  final List<ProductModel> _favouriteProductList = [];
  FavouriteProductBloc() : super(const FavouriteProductState()) {
    on<AddtoFavouriteEvent>(_addToFavourite);
  }

  void _addToFavourite(AddtoFavouriteEvent event, Emitter<FavouriteProductState> emit) {
    final index = state.favouriteProductList.indexWhere((element) => element.id == event.productModel.id);

    if (index == -1) {
      _favouriteProductList.add(event.productModel);
    } else {
      _favouriteProductList.removeAt(index);
    }

    emit(state.copyWith(
      favouriteProductList: List.from(_favouriteProductList),
    ));
  }
}
