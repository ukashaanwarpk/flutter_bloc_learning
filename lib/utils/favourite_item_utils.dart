import 'package:flutter_bloc_learning/model/favourite_item_model.dart';

class FavouriteItemUtils {
  Future<List<FavouriteItemModel>> fetchItems() async {
    await Future.delayed(Duration(seconds: 3));

    return List.from(_generateList(10));
  }

  List<FavouriteItemModel> _generateList(int length) {
    return List.generate(
      length,
      (index) => FavouriteItemModel(id: index.toString(), title: 'Item $index'),
    );
  }
}
