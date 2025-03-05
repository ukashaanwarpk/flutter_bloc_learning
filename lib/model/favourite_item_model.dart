import 'package:equatable/equatable.dart';

class FavouriteItemModel extends Equatable {
  final String id;
  final String title;
  final bool isFavourite;
  final bool isCheck;

  const FavouriteItemModel({
    required this.id,
    required this.title,
    this.isFavourite = false,
    this.isCheck = false,
  });

  @override
  List<Object?> get props => [id, title, isFavourite, isCheck];

  FavouriteItemModel copyWith(
      {String? id, String? title, bool? isFavourite, bool? isCheck}) {
    return FavouriteItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isFavourite: isFavourite ?? this.isFavourite,
      isCheck: isCheck ?? this.isCheck,
    );
  }
}
