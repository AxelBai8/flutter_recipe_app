import 'package:equatable/equatable.dart';

abstract class RecipeListEvent extends Equatable {
  const RecipeListEvent();

  @override
  List<Object> get props => [];
}

class GetInitialRecipes extends RecipeListEvent {}

class FetchMoreRecipes extends RecipeListEvent {} // <-- NUEVO