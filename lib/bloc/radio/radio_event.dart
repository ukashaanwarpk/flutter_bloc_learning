import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_learning/ui/radio_tile_screen.dart';

abstract class RadioEvent extends Equatable {
  const RadioEvent();
}

class ChangeRadio extends RadioEvent {
  final int value;
  const ChangeRadio({required this.value});

  @override
  List<Object?> get props => [value];
}

class ChangeValue extends RadioEvent {
  final Filter filter;
  const ChangeValue({required this.filter});

  @override
  List<Object?> get props => [filter];
}
