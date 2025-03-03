import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/counter/counter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/image_picker/image_picker_bloc.dart';
import 'package:flutter_bloc_learning/bloc/radio/radio_bloc.dart';
import 'package:flutter_bloc_learning/bloc/switch/switch_bloc.dart';
import 'package:flutter_bloc_learning/ui/counter_screen.dart';
import 'package:flutter_bloc_learning/ui/image_picker_screen.dart';
import 'package:flutter_bloc_learning/utils/image_picker_utils.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/theme/theme_bloc.dart';
import 'bloc/theme/theme_state.dart';
import 'ui/radio_tile_screen.dart';
import 'ui/slider_and_switch_screen.dart';
import 'ui/theme_change_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterBloc()),
        BlocProvider(create: (create) => ThemeBloc()),
        BlocProvider(create: (create) => SwitchBloc()),
        BlocProvider(create: (create) => ImagePickerBloc(ImagePickerUtils())),
        BlocProvider(create: (create) => RadioBloc()),
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
            home: RadioTileScreen(),
          );
        },
      ),
    );
  }
}
