import 'package:equatable/equatable.dart';

abstract class GetApiEvent extends Equatable {
  const GetApiEvent();

  @override
  List<Object?> get props => [];
}

class FetchItem extends GetApiEvent {}
