import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class AddTodoEvent extends TodoEvent {
  final String item;
  const AddTodoEvent({required this.item});

  @override
  List<Object?> get props => [item];
}

class DeleteTodoEvent extends TodoEvent {
  final Object item;
  const DeleteTodoEvent({required this.item});

  @override
  List<Object?> get props => [item];
}
