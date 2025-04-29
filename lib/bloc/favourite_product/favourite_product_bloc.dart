import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_learning/bloc/favourite_product/favourite_product_event.dart';
import 'package:flutter_bloc_learning/bloc/favourite_product/favourite_product_state.dart';
import 'package:flutter_bloc_learning/model/product_model.dart';
import 'package:flutter_bloc_learning/utils/local_storage.dart';

class FavouriteProductBloc extends Bloc<FavouriteProductEvent, FavouriteProductState> {
  final List<ProductModel> _favouriteProductList = [];
  FavouriteProductBloc() : super(const FavouriteProductState()) {
    on<AddtoFavouriteEvent>(_addToFavourite);
    on<LoadFromStorage>(_loadFromStorage);
    add((LoadFromStorage()));
  }

  void _addToFavourite(AddtoFavouriteEvent event, Emitter<FavouriteProductState> emit) async {
    final index = state.favouriteProductList.indexWhere((element) => element.id == event.productModel.id);

    if (index == -1) {
      _favouriteProductList.add(event.productModel);
    } else {
      _favouriteProductList.removeAt(index);
    }

    final success = await TLocalStorage.saveData('favourite_items', _favouriteProductList);
    debugPrint(success ? 'Saved favourites' : 'Failed to save favourites');

    emit(state.copyWith(
      favouriteProductList: List.from(_favouriteProductList),
    ));
  }

  void _loadFromStorage(LoadFromStorage event, Emitter<FavouriteProductState> emit) async {
    final data = await TLocalStorage.getData('favourite_items');
    if (data != null) {
      _favouriteProductList.addAll((data as List).cast<ProductModel>());
      emit(state.copyWith(
        favouriteProductList: List.from(_favouriteProductList),
      ));
    }
  }
}
