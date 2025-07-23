import 'package:equatable/equatable.dart';
import '../../domain/entities/recipe.dart';

abstract class RecipeState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Estado inicial (no se ha hecho nada aún)
class RecipeInitial extends RecipeState {}

// Estado de carga (muestra CircularProgressIndicator)
class RecipeLoading extends RecipeState {}

// Estado con recetas cargadas
class RecipeLoaded extends RecipeState {
  final List<Recipe> recipes;
  final bool hasReachedMax;

  RecipeLoaded({required this.recipes, required this.hasReachedMax});

  RecipeLoaded copyWith({
    List<Recipe>? recipes,
    bool? hasReachedMax,
  }) {
    return RecipeLoaded(
      recipes: recipes ?? this.recipes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [recipes, hasReachedMax];
}

// Estado de error
class RecipeError extends RecipeState {
  final String message;

  RecipeError({required this.message});

  @override
  List<Object?> get props => [message];
}

