import 'package:recetas_app/features/recipes/domain/entities/recipe.dart';

class RecipeDetail extends Recipe {
  final String instructions;
  final List<Map<String, String>> ingredients; // Lista de mapas: {'ingredient': '...', 'measure': '...'}

  const RecipeDetail({
    required String id,
    required String name,
    required String imageUrl,
    required this.instructions,
    required this.ingredients,
  }) : super(id: id, name: name, imageUrl: imageUrl);

  @override
  List<Object?> get props => super.props..addAll([instructions, ingredients]);
}
