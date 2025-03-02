import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/counter/counter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/counter/counter_event.dart';
import 'package:flutter_bloc_learning/bloc/counter/counter_state.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    debugPrint('The build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Screen'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              debugPrint('The build inside BlocBuilder');
              return Center(
                child: Text(
                  state.count.toString(),
                  style: TextStyle(fontSize: 50),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<CounterBloc>().add(IncrementEvent());
                },
                child: Text('Increment'),
              ),
              SizedBox(width: 20),
              BlocBuilder<CounterBloc, CounterState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (state.count > 0) {
                        context.read<CounterBloc>().add(DecrementEvent());
                      }
                    },
                    child: Text('Decrement'),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
