import 'package:dartz/dartz.dart';
import 'package:recetas_app/core/error/failures.dart';
import 'package:recetas_app/core/usecases/usecase.dart';
import 'package:recetas_app/features/recipes/domain/entities/recipe_detail.dart';
import 'package:recetas_app/features/recipes/domain/repositories/recipe_repository.dart';

class GetRecipeDetail implements UseCase<RecipeDetail, String> {
  final RecipeRepository repository;

  GetRecipeDetail(this.repository);

  @override
  Future<Either<Failure, RecipeDetail>> call(String id) async {
    return await repository.getRecipeDetail(id);
  }
}