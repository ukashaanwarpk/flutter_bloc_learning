import 'package:equatable/equatable.dart';

class TodoState extends Equatable {
  final List<String> items;

  const TodoState({this.items = const []});

  @override
  List<Object?> get props => [items];

  TodoState copyWith({List<String>? items}) {
    return TodoState(items: items ?? this.items);
  }
}
