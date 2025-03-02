import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_learning/bloc/switch/switch_event.dart';
import 'package:flutter_bloc_learning/bloc/switch/switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(const SwitchState()) {
    on<EnableSwitch>(_onEnableSwitch);
    on<DisableSwitch>(_onDisableSwitch);
    on<SliderEvent>(_onSliderEvent);
  }

  void _onEnableSwitch(EnableSwitch event, Emitter<SwitchState> emit) {
    emit(state.copyWith(isEnable: true));
  }

  void _onDisableSwitch(DisableSwitch event, Emitter<SwitchState> emit) {
    emit(state.copyWith(isEnable: false));
  }

  void _onSliderEvent(SliderEvent event, Emitter<SwitchState> emit) {
    emit(state.copyWith(sliderValue: event.value));
  }
}
