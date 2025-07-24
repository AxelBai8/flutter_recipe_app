import 'package:recetas_app/features/recipes/domain/entities/recipe_detail.dart';

class RecipeDetailModel extends RecipeDetail {
  const RecipeDetailModel({
    required String id,
    required String name,
    required String imageUrl,
    required String instructions,
    required List<Map<String, String>> ingredients,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          instructions: instructions,
          ingredients: ingredients,
        );

  factory RecipeDetailModel.fromJson(Map<String, dynamic> json) {
    List<Map<String, String>> ingredientsList = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null && ingredient.isNotEmpty) {
        ingredientsList.add({'ingredient': ingredient, 'measure': measure ?? ''});
      }
    }

    return RecipeDetailModel(
      id: json['idMeal'],
      name: json['strMeal'],
      imageUrl: json['strMealThumb'],
      instructions: json['strInstructions'],
      ingredients: ingredientsList,
    );
  }
}