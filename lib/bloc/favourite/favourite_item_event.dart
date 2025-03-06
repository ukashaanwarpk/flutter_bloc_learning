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

class SelectItem extends FavouriteItemEvent {
  final FavouriteItemModel favouriteItemModel;

  const SelectItem({required this.favouriteItemModel});

  @override
  List<Object?> get props => [favouriteItemModel];
}

class UnSelectItem extends FavouriteItemEvent {
  final FavouriteItemModel favouriteItemModel;

  const UnSelectItem({required this.favouriteItemModel});

  @override
  List<Object?> get props => [favouriteItemModel];
}

class DeleteItem extends FavouriteItemEvent {
  const DeleteItem();
}
