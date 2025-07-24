import 'package:equatable/equatable.dart';
import 'package:recetas_app/features/recipes/domain/entities/recipe.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchState {}
class SearchLoading extends SearchState {}
class SearchLoaded extends SearchState {
  final List<Recipe> recipes;
  const SearchLoaded({required this.recipes});
}
class SearchError extends SearchState {
  final String message;
  const SearchError({required this.message});
}
