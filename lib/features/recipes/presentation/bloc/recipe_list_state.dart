import 'package:equatable/equatable.dart';
import 'package:recetas_app/features/recipes/domain/entities/recipe.dart';

abstract class RecipeListState extends Equatable {
  const RecipeListState();

  @override
  List<Object> get props => [];
}

class Empty extends RecipeListState {}

class Loading extends RecipeListState {}

class Loaded extends RecipeListState {
  final List<Recipe> recipes;
  final bool hasReachedMax; 

  const Loaded({
    required this.recipes,
    required this.hasReachedMax, 
  });

  // Creamos un método 'copyWith' para facilitar la actualización del estado
  Loaded copyWith({
    List<Recipe>? recipes,
    bool? hasReachedMax,
  }) {
    return Loaded(
      recipes: recipes ?? this.recipes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [recipes, hasReachedMax];
}

class Error extends RecipeListState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
