import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:recetas_app/features/recipes/data/datasources/recipe_remote_data_source.dart';
import 'package:recetas_app/features/recipes/data/repositories/recipe_repository_impl.dart';
import 'package:recetas_app/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:recetas_app/features/recipes/domain/usecases/get_recipes.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/recipe_list_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Recipes
  // Bloc
  sl.registerFactory(
    () => RecipeListBloc(getRecipes: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetRecipes(sl()));

  // Repository
  sl.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSourceImpl(client: sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}