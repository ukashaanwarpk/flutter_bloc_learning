import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_learning/bloc/get_api/get_api_event.dart';
import 'package:flutter_bloc_learning/bloc/get_api/get_api_state.dart';
import 'package:flutter_bloc_learning/model/get_model.dart';
import 'package:flutter_bloc_learning/repository/get_repository.dart';
import 'package:flutter_bloc_learning/utils/enum.dart';

class GetApiBloc extends Bloc<GetApiEvent, GetApiState> {
  final GetRepository getRepository;

  List<GetModel> tempList = [];
  GetApiBloc(this.getRepository) : super(GetApiState()) {
    on<FetchItem>(_fetchItem);
    on<SearchItem>(_searchItem);
  }

  void _fetchItem(FetchItem event, Emitter<GetApiState> emit) async {
    try {
      final List<GetModel> items = await getRepository.getApiData();

      emit(state.copyWith(
          getStatus: GetStatus.success, message: 'Success', getItem: items));
    } catch (e) {
      emit(
        state.copyWith(
          getStatus: GetStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  void _searchItem(SearchItem event, Emitter<GetApiState> emit) async {
    // If the search query is empty, reset the search results

    if (event.query.isEmpty) {
      emit(
        state.copyWith(tempList: const <GetModel>[], searchMessage: ''),
      );
      return;
    } else {
      tempList = state.getItem
          .where((item) => item.email
              .toString()
              .toLowerCase()
              .contains(event.query.toLowerCase()))
          .toList();

      if (tempList.isEmpty) {
        emit(state.copyWith(
          tempList: const <GetModel>[],
          searchMessage: 'No items found for "${event.query}"',
        ));
      } else {
        emit(state.copyWith(
          tempList: tempList,
          searchMessage: '',
        ));
      }
    }
  }
}
