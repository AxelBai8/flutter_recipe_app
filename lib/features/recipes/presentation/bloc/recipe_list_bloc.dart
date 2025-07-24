import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recetas_app/features/recipes/domain/usecases/get_recipes.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/recipe_list_event.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/recipe_list_state.dart';
import 'package:rxdart/rxdart.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const throttleDuration = Duration(milliseconds: 100);

// Función corregida para throttle + droppable
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return events
        .throttleTime(duration)  // Usamos throttleTime en lugar de throttle
        .switchMap(mapper);      // switchMap cancela peticiones anteriores
  };
}

class RecipeListBloc extends Bloc<RecipeListEvent, RecipeListState> {
  final GetRecipes getRecipes;
  String _currentLetter = 'a';

  RecipeListBloc({required this.getRecipes}) : super(Empty()) {
    on<GetInitialRecipes>(_onGetInitialRecipes);
    on<FetchMoreRecipes>(
      _onFetchMoreRecipes,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onGetInitialRecipes(
    GetInitialRecipes event,
    Emitter<RecipeListState> emit,
  ) async {
    _currentLetter = 'a';
    emit(Loading());
    final failureOrRecipes = await getRecipes(_currentLetter);
    failureOrRecipes.fold(
      (failure) => emit(const Error(message: SERVER_FAILURE_MESSAGE)),
      (recipes) => emit(Loaded(recipes: recipes, hasReachedMax: recipes.isEmpty)),
    );
  }

  Future<void> _onFetchMoreRecipes(
    FetchMoreRecipes event,
    Emitter<RecipeListState> emit,
  ) async {
    // Si ya estamos en un estado 'Loaded' y no hemos llegado al final
    if (state is Loaded && !(state as Loaded).hasReachedMax) {
      final currentState = state as Loaded;
      
      // Avanzamos a la siguiente letra
      _currentLetter = String.fromCharCode(_currentLetter.codeUnitAt(0) + 1);
      
      // Si llegamos más allá de la 'z', paramos.
      if (_currentLetter.codeUnitAt(0) > 'z'.codeUnitAt(0)) {
        emit(currentState.copyWith(hasReachedMax: true));
        return;
      }

      final failureOrRecipes = await getRecipes(_currentLetter);
      failureOrRecipes.fold(
        (failure) => emit(const Error(message: SERVER_FAILURE_MESSAGE)),
        (newRecipes) {
          if (newRecipes.isEmpty) {
            // Si no hay más recetas, marcamos que hemos llegado al final
            emit(currentState.copyWith(hasReachedMax: true));
          } else {
            // Añadimos las nuevas recetas a la lista existente
            emit(currentState.copyWith(
              recipes: List.of(currentState.recipes)..addAll(newRecipes),
              hasReachedMax: false,
            ));
          }
        },
      );
    }
  }
}
