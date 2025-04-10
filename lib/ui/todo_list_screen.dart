import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/todo/todo_bloc.dart';
import 'package:flutter_bloc_learning/bloc/todo/todo_event.dart';
import 'package:flutter_bloc_learning/bloc/todo/todo_state.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
        foregroundColor: Colors.white,
        onPressed: () {
          for (int i = 0; i <= 5; i++) {
            context.read<TodoBloc>().add(
                  AddTodoEvent(item: 'items $i'),
                );
          }
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('ToDo List'),
        centerTitle: true,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        if (state.items.isEmpty) {
          return const Center(
            child: Text('No item found'),
          );
        } else if (state.items.isNotEmpty) {
          return ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.items[index].toString()),
                trailing: IconButton(
                  onPressed: () {
                    context.read<TodoBloc>().add(
                          DeleteTodoEvent(item: state.items[index]),
                        );
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
