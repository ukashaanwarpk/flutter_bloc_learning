import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_learning/model/favourite_item_model.dart';

class FavouriteItemEvent extends Equatable {
  const FavouriteItemEvent();

  @override
  List<Object?> get props => [];
}

class FetchFavouriteItems extends FavouriteItemEvent {
  const FetchFavouriteItems();
}

class AddToFavourite extends FavouriteItemEvent {
  final FavouriteItemModel favouriteItemModel;
  const AddToFavourite({required this.favouriteItemModel});

  @override
  List<Object?> get props => [favouriteItemModel];
}
