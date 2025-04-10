import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/theme/theme.event.dart';
import '../bloc/theme/theme_bloc.dart';
import '../bloc/theme/theme_state.dart';

class ThemeChangeScreen extends StatefulWidget {
  const ThemeChangeScreen({super.key});

  @override
  State<ThemeChangeScreen> createState() => _ThemeChangeScreenState();
}

class _ThemeChangeScreenState extends State<ThemeChangeScreen> {
  @override
  Widget build(BuildContext context) {
    debugPrint('ThemeChangeScreen build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Change'),
        centerTitle: true,
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          debugPrint('ThemeChangeScreen BlocBuilder build');
          return ListTile(
            title: Text(state.isDark ? 'Dark Theme' : 'Light Theme'),
            trailing: CupertinoSwitch(
              value: state.isDark,
              onChanged: (value) {
                context.read<ThemeBloc>().add(ChangeTheme());
              },
            ),
          );
        },
      ),
    );
  }
}
