import 'package:dartz/dartz.dart';
import 'package:recetas_app/core/error/failures.dart';
import 'package:recetas_app/features/recipes/domain/entities/recipe.dart';
import 'package:recetas_app/features/recipes/domain/entities/recipe_detail.dart';


abstract class RecipeRepository {
  Future<Either<Failure, List<Recipe>>> getRecipesByFirstLetter(String letter);
  Future<Either<Failure, RecipeDetail>> getRecipeDetail(String id);
  Future<Either<Failure, List<Recipe>>> searchRecipes(String query);
}

