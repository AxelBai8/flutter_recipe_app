import 'package:equatable/equatable.dart';

abstract class RecipeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Evento: cargar recetas
class FetchRecipes extends RecipeEvent {}

