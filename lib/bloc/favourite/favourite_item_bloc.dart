import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_learning/bloc/favourite/favourite_item_event.dart';
import 'package:flutter_bloc_learning/bloc/favourite/favourite_item_state.dart';
import 'package:flutter_bloc_learning/model/favourite_item_model.dart';
import 'package:flutter_bloc_learning/utils/favourite_item_utils.dart';

class FavouriteItemBloc extends Bloc<FavouriteItemEvent, FavouriteItemState> {
  List<FavouriteItemModel> favouriteItemList = [];
  final FavouriteItemUtils favouriteItemUtils;

  FavouriteItemBloc(this.favouriteItemUtils) : super(FavouriteItemState()) {
    on<FetchFavouriteItems>(_fetchFavouriteItems);
    on<AddToFavourite>(_addToFavourite);
  }

  void _fetchFavouriteItems(
      FetchFavouriteItems event, Emitter<FavouriteItemState> emit) async {
    favouriteItemList = await favouriteItemUtils.fetchItems();

    emit(
      state.copyWith(
          favouriteItemModel: List.from(favouriteItemList),
          loadingState: LoadingState.completed),
    );
  }

  void _addToFavourite(AddToFavourite event, Emitter<FavouriteItemState> emit) {
    final index = favouriteItemList.indexWhere(
      (element) => element.id == event.favouriteItemModel.id,
    );

    favouriteItemList[index] = event.favouriteItemModel;
    emit(
      state.copyWith(
        favouriteItemModel: List.from(favouriteItemList),
      ),
    );
  }
}
