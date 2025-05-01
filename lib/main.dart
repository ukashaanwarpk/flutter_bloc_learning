import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/cart/cart_bloc.dart';
import 'package:flutter_bloc_learning/bloc/favourite/favourite_item_bloc.dart';
import 'package:flutter_bloc_learning/bloc/favourite_product/favourite_product_bloc.dart';
import 'package:flutter_bloc_learning/bloc/get_api/get_api_bloc.dart';
import 'package:flutter_bloc_learning/bloc/image_picker/image_picker_bloc.dart';
import 'package:flutter_bloc_learning/bloc/product/product_bloc.dart';
import 'package:flutter_bloc_learning/bloc/radio/radio_bloc.dart';
import 'package:flutter_bloc_learning/bloc/switch/switch_bloc.dart';
import 'package:flutter_bloc_learning/bloc/todo/todo_bloc.dart';
import 'package:flutter_bloc_learning/model/cart_model.dart';
import 'package:flutter_bloc_learning/model/product_model.dart';
import 'package:flutter_bloc_learning/repository/get_repository.dart';
import 'package:flutter_bloc_learning/repository/product_repository.dart';
import 'package:flutter_bloc_learning/ui/navigation_menu.dart';
import 'package:flutter_bloc_learning/utils/favourite_item_utils.dart';
import 'package:flutter_bloc_learning/utils/image_picker_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/theme/theme_bloc.dart';
import 'bloc/theme/theme_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(RatingAdapter());
  Hive.registerAdapter(CartModelAdapter());

  await Hive.openBox('favourite_items_box');
  await Hive.openBox('cart_items_box');
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
        BlocProvider(create: (create) => FavouriteItemBloc(FavouriteItemUtils())),
        BlocProvider(create: (create) => GetApiBloc(GetRepository())),
        BlocProvider(create: (create) => ProductBloc(ProductRepository())),
        BlocProvider(create: (create) => CartBloc()),
        BlocProvider(create: (create) => FavouriteProductBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Bloc learning',
            darkTheme: ThemeData.dark(),
            themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
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
            home: const NavigationMenu(),
          );
        },
      ),
    );
  }
}
