import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recetas_app/features/recipes/domain/usecases/search_recipes.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/search/search_event.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/search/search_state.dart';
import 'package:rxdart/rxdart.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRecipes searchRecipes;

  SearchBloc({required this.searchRecipes}) : super(SearchEmpty()) {
    on<TextChanged>((event, emit) async {
      final query = event.query;
      if (query.isEmpty) {
        return emit(SearchEmpty());
      }
      emit(SearchLoading());
      final failureOrSearch = await searchRecipes(query);
      failureOrSearch.fold(
        (failure) => emit(const SearchError(message: SERVER_FAILURE_MESSAGE)),
        (recipes) => emit(SearchLoaded(recipes: recipes)),
      );
    },
    // Transformador para el debounce
    transformer: (events, mapper) {
      return events.debounceTime(const Duration(milliseconds: 500)).asyncExpand(mapper);
    });
  }
}
