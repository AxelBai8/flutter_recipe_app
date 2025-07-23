import 'package:flutter_bloc/flutter_bloc.dart';
import 'recipe_event.dart';
import 'recipe_state.dart';
import '../../domain/usecases/get_recipes.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GetAllRecipes getAllRecipes;

  int page = 1;
  final int pageSize = 10;

  RecipeBloc({required this.getAllRecipes}) : super(RecipeInitial()) {
    on<FetchRecipes>(_onFetchRecipes);
  }

  Future<void> _onFetchRecipes(FetchRecipes event, Emitter<RecipeState> emit) async {
    final currentState = state;
    try {
      if (currentState is RecipeInitial) {
        final recipes = await getAllRecipes(page, pageSize);
        emit(RecipeLoaded(recipes: recipes, hasReachedMax: false));
      } else if (currentState is RecipeLoaded && !currentState.hasReachedMax) {
        page++;
        final newRecipes = await getAllRecipes(page, pageSize);
        if (newRecipes.isEmpty) {
          emit(currentState.copyWith(hasReachedMax: true));
        } else {
          emit(RecipeLoaded(
            recipes: currentState.recipes + newRecipes,
            hasReachedMax: false,
          ));
        }
      }
    } catch (e) {
      emit(RecipeError(message: e.toString()));
    }
  }
}

