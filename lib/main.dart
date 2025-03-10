import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/counter/counter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/favourite/favourite_item_bloc.dart';
import 'package:flutter_bloc_learning/bloc/get_api/get_api_bloc.dart';
import 'package:flutter_bloc_learning/bloc/image_picker/image_picker_bloc.dart';
import 'package:flutter_bloc_learning/bloc/radio/radio_bloc.dart';
import 'package:flutter_bloc_learning/bloc/switch/switch_bloc.dart';
import 'package:flutter_bloc_learning/bloc/todo/todo_bloc.dart';
import 'package:flutter_bloc_learning/repository/get_repository.dart';
import 'package:flutter_bloc_learning/ui/counter_screen.dart';
import 'package:flutter_bloc_learning/ui/get_api_screen.dart';
import 'package:flutter_bloc_learning/ui/image_picker_screen.dart';
import 'package:flutter_bloc_learning/ui/login_screen.dart';
import 'package:flutter_bloc_learning/utils/favourite_item_utils.dart';
import 'package:flutter_bloc_learning/utils/image_picker_utils.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/theme/theme_bloc.dart';
import 'bloc/theme/theme_state.dart';
import 'ui/favourite_screen.dart';
import 'ui/radio_tile_screen.dart';
import 'ui/slider_and_switch_screen.dart';
import 'ui/theme_change_screen.dart';
import 'ui/todo_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (create) => ThemeBloc()),
        BlocProvider(create: (create) => SwitchBloc()),
        BlocProvider(create: (create) => ImagePickerBloc(ImagePickerUtils())),
        BlocProvider(create: (create) => RadioBloc()),
        BlocProvider(create: (create) => TodoBloc()),
        BlocProvider(
            create: (create) => FavouriteItemBloc(FavouriteItemUtils())),
        BlocProvider(create: (create) => GetApiBloc(GetRepository())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Bloc learning',
            darkTheme: ThemeData.dark(),
            themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.indigoAccent,
                foregroundColor: Colors.white,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.indigoAccent),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                ),
              ),
              textTheme: GoogleFonts.interTextTheme(),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}
