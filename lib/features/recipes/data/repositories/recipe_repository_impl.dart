import 'package:dartz/dartz.dart';
import 'package:recetas_app/core/error/exceptions.dart';
import 'package:recetas_app/core/error/failures.dart';
import 'package:recetas_app/features/recipes/data/datasources/recipe_remote_data_source.dart';
import 'package:recetas_app/features/recipes/domain/entities/recipe.dart';
import 'package:recetas_app/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:recetas_app/features/recipes/domain/entities/recipe_detail.dart';


class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;
  // final NetworkInfo networkInfo; // Opcional, para verificar conexión

  RecipeRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Recipe>>> getRecipesByFirstLetter(String letter) async {
    // Aquí se podría verificar si hay conexión a internet
    try {
      final remoteRecipes = await remoteDataSource.getRecipesByFirstLetter(letter);
      return Right(remoteRecipes);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, RecipeDetail>> getRecipeDetail(String id) async {
    try {
      final remoteDetail = await remoteDataSource.getRecipeDetail(id);
      return Right(remoteDetail);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
