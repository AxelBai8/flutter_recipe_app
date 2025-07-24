import 'package:equatable/equatable.dart';
import 'package:recetas_app/features/recipes/domain/entities/recipe_detail.dart';

abstract class RecipeDetailState extends Equatable {
  const RecipeDetailState();
  @override
  List<Object> get props => [];
}

class DetailEmpty extends RecipeDetailState {}
class DetailLoading extends RecipeDetailState {}
class DetailLoaded extends RecipeDetailState {
  final RecipeDetail recipeDetail;
  const DetailLoaded({required this.recipeDetail});
}
class DetailError extends RecipeDetailState {
  final String message;
  const DetailError({required this.message});
}
