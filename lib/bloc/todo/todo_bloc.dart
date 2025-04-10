import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_learning/bloc/todo/todo_event.dart';
import 'package:flutter_bloc_learning/bloc/todo/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final List<String> todoList = [];
  TodoBloc() : super(const TodoState()) {
    on<AddTodoEvent>(_addTodoEvent);
    on<DeleteTodoEvent>(_deleteTodoEvent);
  }

  void _addTodoEvent(AddTodoEvent event, Emitter<TodoState> emit) {
    todoList.add(event.item);
    emit(state.copyWith(items: List.from(todoList)));
  }

  void _deleteTodoEvent(DeleteTodoEvent event, Emitter<TodoState> emit) {
    todoList.remove(event.item);
    emit(state.copyWith(items: List.from(todoList)));
  }
}
