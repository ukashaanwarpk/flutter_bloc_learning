import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_learning/bloc/get_api/get_api_event.dart';
import 'package:flutter_bloc_learning/bloc/get_api/get_api_state.dart';
import 'package:flutter_bloc_learning/model/get_model.dart';
import 'package:flutter_bloc_learning/repository/get_repository.dart';
import 'package:flutter_bloc_learning/utils/enum.dart';

class GetApiBloc extends Bloc<GetApiEvent, GetApiState> {
  final GetRepository getRepository;
  GetApiBloc(this.getRepository) : super(GetApiState()) {
    on<FetchItem>(_fetchItem);
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
}
