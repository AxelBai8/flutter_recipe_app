import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe_model.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> getAllRecipes(int page, int pageSize);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final http.Client client;

  RecipeRemoteDataSourceImpl(this.client);

  @override
  Future<List<RecipeModel>> getAllRecipes(int page, int pageSize) async {
    final url = Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List meals = data['meals'];

      // TheMealDB no tiene paginación real, así que simulamos paginado aquí:
      final start = (page - 1) * pageSize;
      final end = start + pageSize;
      final pagedMeals = meals.sublist(
        start < meals.length ? start : meals.length,
        end < meals.length ? end : meals.length,
      );

      return pagedMeals.map((json) => RecipeModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
