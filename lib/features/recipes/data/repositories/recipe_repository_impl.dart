import 'package:dartz/dartz.dart';
import 'package:recetas_app/core/error/exceptions.dart';
import 'package:recetas_app/core/error/failures.dart';
import 'package:recetas_app/features/recipes/data/datasources/recipe_remote_data_source.dart';
import 'package:recetas_app/features/recipes/domain/entities/recipe.dart';
import 'package:recetas_app/features/recipes/domain/entities/recipe_detail.dart';
import 'package:recetas_app/features/recipes/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;

  RecipeRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Recipe>>> getRecipesByFirstLetter(String letter) async {
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

  @override
  Future<Either<Failure, List<Recipe>>> searchRecipes(String query) async {
    try {
      final remoteRecipes = await remoteDataSource.searchRecipes(query);
      return Right(remoteRecipes);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}