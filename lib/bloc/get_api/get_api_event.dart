import 'package:equatable/equatable.dart';

abstract class GetApiEvent extends Equatable {
  const GetApiEvent();

  @override
  List<Object?> get props => [];
}

class FetchItem extends GetApiEvent {}

class SearchItem extends GetApiEvent {
  final String query;

  const SearchItem({required this.query});
  @override
  List<Object?> get props => [query];
}
