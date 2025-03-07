import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_learning/model/get_model.dart';

import '../../utils/enum.dart';

class GetApiState extends Equatable {
  final GetStatus getStatus;
  final String message;
  final List<GetModel> getItem;
  const GetApiState({
    this.getStatus = GetStatus.loading,
    this.message = '',
    this.getItem = const <GetModel>[],
  });

  @override
  List<Object?> get props => [getStatus, message, getItem];

  GetApiState copyWith(
      {GetStatus? getStatus, String? message, List<GetModel>? getItem}) {
    return GetApiState(
        getStatus: getStatus ?? this.getStatus,
        message: message ?? this.message,
        getItem: getItem ?? this.getItem);
  }
}
