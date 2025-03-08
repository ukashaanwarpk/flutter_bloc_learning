import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_learning/model/get_model.dart';

import '../../utils/enum.dart';

class GetApiState extends Equatable {
  final GetStatus getStatus;
  final String message;
  final List<GetModel> getItem;
  final List<GetModel> tempList;

  final String searchMessage;

  const GetApiState({
    this.getStatus = GetStatus.loading,
    this.message = '',
    this.getItem = const <GetModel>[],
    this.tempList = const <GetModel>[],
    this.searchMessage = '',
  });

  @override
  List<Object?> get props =>
      [getStatus, message, getItem, tempList, searchMessage];

  GetApiState copyWith(
      {GetStatus? getStatus,
      String? message,
      List<GetModel>? getItem,
      List<GetModel>? tempList,
      String? searchMessage}) {
    return GetApiState(
      getStatus: getStatus ?? this.getStatus,
      message: message ?? this.message,
      getItem: getItem ?? this.getItem,
      tempList: tempList ?? this.tempList,
      searchMessage: searchMessage ?? this.searchMessage,
    );
  }
}
