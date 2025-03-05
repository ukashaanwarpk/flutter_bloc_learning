import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_learning/model/favourite_item_model.dart';

enum LoadingState { loading, completed, error }

class FavouriteItemState extends Equatable {
  final LoadingState loadingState;
  final List<FavouriteItemModel> favouriteItemModel;
  const FavouriteItemState({
    this.favouriteItemModel = const [],
    this.loadingState = LoadingState.loading,
  });

  @override
  List<Object?> get props => [favouriteItemModel, loadingState];

  FavouriteItemState copyWith(
      {List<FavouriteItemModel>? favouriteItemModel,
      LoadingState? loadingState}) {
    return FavouriteItemState(
      favouriteItemModel: favouriteItemModel ?? this.favouriteItemModel,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
