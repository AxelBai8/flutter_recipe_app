import '../../domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  const RecipeModel({
    required String id,
    required String title,
    required String imageUrl,
  }) : super(
          id: id,
          title: title,
          imageUrl: imageUrl,
          description: '',
          ingredients: const [],
        );

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['idMeal'],
      title: json['strMeal'],
      imageUrl: json['strMealThumb'],
    );
  }
}


