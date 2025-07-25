import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:recetas_app/features/recipes/data/datasources/recipe_remote_data_source.dart';
import 'package:recetas_app/features/recipes/data/repositories/recipe_repository_impl.dart';
import 'package:recetas_app/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:recetas_app/features/recipes/domain/usecases/get_recipes.dart';
import 'package:recetas_app/features/recipes/domain/usecases/get_recipe_detail.dart';
import 'package:recetas_app/features/recipes/domain/usecases/search_recipes.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/recipe_list_bloc.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/recipe_detail/recipe_detail_bloc.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/search/search_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl.registerFactory(() => RecipeListBloc(getRecipes: sl()));
  sl.registerFactory(() => RecipeDetailBloc(getRecipeDetail: sl()));
  sl.registerFactory(() => SearchBloc(searchRecipes: sl())); // Asegúrate de tener esta línea

  // Use cases
  sl.registerLazySingleton(() => GetRecipes(sl()));
  sl.registerLazySingleton(() => GetRecipeDetail(sl()));
  sl.registerLazySingleton(() => SearchRecipes(sl())); // Asegúrate de tener esta línea

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