import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_learning/bloc/counter/counter_event.dart';
import 'package:flutter_bloc_learning/bloc/counter/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    on<IncrementEvent>(_increment);
    on<DecrementEvent>(_decrement);
  }

  void _increment(IncrementEvent event, Emitter<CounterState> emit) {
    emit(state.copyWith(count: state.count + 1));
  }

  void _decrement(DecrementEvent event, Emitter<CounterState> emit) {
    if (state.count > 0) {
      emit(state.copyWith(count: state.count - 1));
    }
  }
}
