import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_learning/bloc/radio/radio_event.dart';
import 'package:flutter_bloc_learning/bloc/radio/radio_state.dart';

class RadioBloc extends Bloc<RadioEvent, RadioState> {
  RadioBloc() : super(RadioState()) {
    on<ChangeRadio>(_changeRadio);
    on<ChangeValue>(_changeValue);
  }

  void _changeRadio(ChangeRadio event, Emitter<RadioState> emit) {
    emit(state.copyWith(value: event.value));
  }

  void _changeValue(ChangeValue event, Emitter<RadioState> emit) {
    emit(state.copyWith(filter: event.filter));
  }
}
