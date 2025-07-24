import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/recipe_list_bloc.dart';
import 'package:recetas_app/features/recipes/presentation/pages/home_page.dart';
import 'package:recetas_app/injection_container.dart' as di;
import 'package:recetas_app/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RecipeListBloc>(),
      child: MaterialApp(
        title: 'Recetas App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomePage(),
      ),
    );
  }
}