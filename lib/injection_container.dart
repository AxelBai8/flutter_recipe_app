import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'features/recipes/data/datasources/recipe_remote_data_source.dart';
import 'features/recipes/data/repositories/recipe_repository_impl.dart';
import 'features/recipes/domain/repositories/recipe_repository.dart';
import 'features/recipes/domain/usecases/get_recipes.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => RecipeBloc(getAllRecipes: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetAllRecipes(sl()));

  // Repository
  sl.registerLazySingleton<RecipeRepository>(
      () => RecipeRepositoryImpl(sl()));

  // Data sources
  sl.registerLazySingleton<RecipeRemoteDataSource>(
      () => RecipeRemoteDataSourceImpl(sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
}
