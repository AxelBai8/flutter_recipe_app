import 'package:equatable/equatable.dart';


abstract class RecipeDetailEvent extends Equatable {
  const RecipeDetailEvent();
  @override
  List<Object> get props => [];
}

class GetDetailsForRecipe extends RecipeDetailEvent {
  final String id;
  const GetDetailsForRecipe(this.id);
}