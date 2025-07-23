import 'package:dartz/dartz.dart';
import 'package:recetas_app/core/error/failures.dart';
import 'package:recetas_app/core/usecases/usecase.dart';
import 'package:recetas_app/features/recipes/domain/entities/recipe.dart';
import 'package:recetas_app/features/recipes/domain/repositories/recipe_repository.dart';

class GetRecipes implements UseCase<List<Recipe>, String> {
  final RecipeRepository repository;

  GetRecipes(this.repository);

  @override
  Future<Either<Failure, List<Recipe>>> call(String letter) async {
    return await repository.getRecipesByFirstLetter(letter);
  }
}
