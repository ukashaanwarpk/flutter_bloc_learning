import 'package:equatable/equatable.dart';

class FavouriteItemModel extends Equatable {
  final String id;
  final String title;
  final bool isFavourite;

  const FavouriteItemModel({
    required this.id,
    required this.title,
    this.isFavourite = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        isFavourite,
      ];

  FavouriteItemModel copyWith({
    String? id,
    String? title,
    bool? isFavourite,
  }) {
    return FavouriteItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
