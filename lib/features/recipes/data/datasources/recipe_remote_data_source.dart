import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recetas_app/core/error/exceptions.dart';
import 'package:recetas_app/features/recipes/data/models/recipe_model.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> getRecipesByFirstLetter(String letter);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final http.Client client;

  RecipeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RecipeModel>> getRecipesByFirstLetter(String letter) async {
    final response = await client.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?f=$letter'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null) return [];
      return (data['meals'] as List)
          .map((recipe) => RecipeModel.fromJson(recipe))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
