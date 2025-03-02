import 'package:equatable/equatable.dart';

abstract class SwitchEvent extends Equatable {
  const SwitchEvent();
  @override
  List<Object> get props => [];
}

class EnableSwitch extends SwitchEvent {
  const EnableSwitch();
}

class DisableSwitch extends SwitchEvent {
  const DisableSwitch();
}

class SliderEvent extends SwitchEvent {
  final double value;
  const SliderEvent({required this.value});
  @override
  List<Object> get props => [value];
}
