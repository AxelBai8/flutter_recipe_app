import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recetas_app/features/recipes/domain/usecases/get_recipe_detail.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/recipe_detail/recipe_detail_event.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/recipe_detail/recipe_detail_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  final GetRecipeDetail getRecipeDetail;

  RecipeDetailBloc({required this.getRecipeDetail}) : super(DetailEmpty()) {
    on<GetDetailsForRecipe>((event, emit) async {
      emit(DetailLoading());
      final failureOrDetail = await getRecipeDetail(event.id);
      failureOrDetail.fold(
        (failure) => emit(const DetailError(message: SERVER_FAILURE_MESSAGE)),
        (detail) => emit(DetailLoaded(recipeDetail: detail)),
      );
    });
  }
}