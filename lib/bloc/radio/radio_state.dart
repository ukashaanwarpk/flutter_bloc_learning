import 'package:equatable/equatable.dart';

import '../../ui/radio_tile_screen.dart';

class RadioState extends Equatable {
  final int value;
  final Filter filter;
  const RadioState({this.value = 1, this.filter = Filter.priceHighToLow});

  @override
  List<Object?> get props => [value, filter];

  RadioState copyWith({int? value, Filter? filter}) {
    return RadioState(
        value: value ?? this.value, filter: filter ?? this.filter);
  }
}
