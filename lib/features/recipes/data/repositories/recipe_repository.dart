import '../entities/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getAllRecipes(int page, int pageSize);
}