import 'package:dartz/dartz.dart';
import 'package:recetas_app/core/error/failures.dart';
import 'package:recetas_app/features/recipes/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<Recipe>>> getRecipesByFirstLetter(String letter);
  // Dejaremos los otros métodos para después
  // Future<Either<Failure, RecipeDetail>> getRecipeDetail(String id);
  // Future<Either<Failure, List<Recipe>>> searchRecipes(String query);
}