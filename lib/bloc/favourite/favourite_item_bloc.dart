import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_learning/bloc/favourite/favourite_item_event.dart';
import 'package:flutter_bloc_learning/bloc/favourite/favourite_item_state.dart';
import 'package:flutter_bloc_learning/model/favourite_item_model.dart';
import 'package:flutter_bloc_learning/utils/favourite_item_utils.dart';

class FavouriteItemBloc extends Bloc<FavouriteItemEvent, FavouriteItemState> {
  List<FavouriteItemModel> favouriteItemList = [];
  List<FavouriteItemModel> tempItemList = [];

  final FavouriteItemUtils favouriteItemUtils;

  FavouriteItemBloc(this.favouriteItemUtils) : super(const FavouriteItemState()) {
    on<FetchFavouriteItems>(_fetchFavouriteItems);
    on<AddToFavourite>(_addToFavourite);
    on<SelectItem>(_selectItem);
    on<UnSelectItem>(_unSelectItem);
    on<DeleteItem>(_deleteItem);
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

    // we select item and also add to favourite. then item will not unselect.

    // The reason is that when we select item , the item object is adding in temp list.
    // but when we add item to favourite the object state changes so to update data in
    // temp list we are doing below step.

    // Check if the item is also in the temporary selection list
    final tempIndex = tempItemList.indexWhere(
      (element) => element.id == event.favouriteItemModel.id,
    );

    // If the item exists in tempItemList, update it there too
    //  If no matching element is found, indexWhere() returns -1 as a special value indicating "not found".
    if (tempIndex != -1) {
      tempItemList[tempIndex] = event.favouriteItemModel;
    }
    emit(
      state.copyWith(
        favouriteItemModel: List.from(favouriteItemList),
        tempList: List.from(tempItemList),
      ),
    );
  }

  void _selectItem(SelectItem event, Emitter<FavouriteItemState> emit) {
    tempItemList.add(event.favouriteItemModel);

    emit(
      state.copyWith(
        tempList: List.from(tempItemList),
      ),
    );
  }

  void _unSelectItem(UnSelectItem event, Emitter<FavouriteItemState> emit) {
    tempItemList.remove(event.favouriteItemModel);

    emit(
      state.copyWith(
        tempList: List.from(tempItemList),
      ),
    );
  }

  void _deleteItem(DeleteItem event, Emitter<FavouriteItemState> emit) {
    // Remove all items in tempItemList from favouriteItemList
    favouriteItemList.removeWhere((item) => tempItemList.contains(item));

    // Clear the temporary list after deletion is complete
    tempItemList.clear();

    // Emit the new state with updated lists
    emit(
      state.copyWith(
        favouriteItemModel: List.from(favouriteItemList),
        tempList: List.from(tempItemList),
      ),
    );
  }
}
