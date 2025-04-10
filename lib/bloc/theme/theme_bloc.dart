import 'package:bloc/bloc.dart';
import 'theme.event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<ThemeEvent>(_changeTheme);
  }

  void _changeTheme(ThemeEvent event, Emitter<ThemeState> emit) {
    emit(state.copyWith(isDark: !state.isDark));
  }
}
