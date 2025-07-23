import 'package:recetas_app/features/recipes/domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  const RecipeModel({
    required String id,
    required String name,
    required String imageUrl,
  }) : super(id: id, name: name, imageUrl: imageUrl);

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['idMeal'],
      name: json['strMeal'],
      imageUrl: json['strMealThumb'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': id,
      'strMeal': name,
      'strMealThumb': imageUrl,
    };
  }
}