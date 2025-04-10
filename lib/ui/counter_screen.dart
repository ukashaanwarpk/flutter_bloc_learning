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
  late CounterBloc _counterBloc;

  @override
  initState() {
    super.initState();
    _counterBloc = CounterBloc();
  }

  @override
  dispose() {
    _counterBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('The build');
    return BlocProvider(
      create: (_) => _counterBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Counter Screen'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                debugPrint('The build inside BlocBuilder');
                return Center(
                  child: Text(
                    state.count.toString(),
                    style: const TextStyle(fontSize: 50),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<CounterBloc, CounterState>(
                  buildWhen: (curent, previous) => false,
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        context.read<CounterBloc>().add(IncrementEvent());
                      },
                      child: const Text('Increment'),
                    );
                  },
                ),
                const SizedBox(width: 20),
                BlocBuilder<CounterBloc, CounterState>(
                  buildWhen: (curent, previous) => false,
                  builder: (context, state) {
                    debugPrint('De');
                    return ElevatedButton(
                      onPressed: () {
                        context.read<CounterBloc>().add(DecrementEvent());
                      },
                      child: const Text('Decrement'),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
