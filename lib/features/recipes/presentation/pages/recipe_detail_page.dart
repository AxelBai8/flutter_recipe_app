import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/recipe_detail/recipe_detail_bloc.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/recipe_detail/recipe_detail_event.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/recipe_detail/recipe_detail_state.dart';
import 'package:recetas_app/injection_container.dart';

class RecipeDetailPage extends StatelessWidget {
  final String recipeId;
  final String recipeName;
  final String recipeImageUrl;

  const RecipeDetailPage({
    super.key,
    required this.recipeId,
    required this.recipeName,
    required this.recipeImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RecipeDetailBloc>()..add(GetDetailsForRecipe(recipeId)),
      child: Scaffold(
        body: BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
          builder: (context, state) {
            if (state is DetailLoading || state is DetailEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DetailLoaded) {
              final recipe = state.recipeDetail;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 300.0,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        recipe.name,
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      background: Hero(
                        tag: 'recipe-${recipe.id}',
                        child: CachedNetworkImage(
                          imageUrl: recipe.imageUrl,
                          fit: BoxFit.cover,
                          color: Colors.black.withOpacity(0.3),
                          colorBlendMode: BlendMode.darken,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ingredientes',
                              style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            ...recipe.ingredients.map((ing) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text('• ${ing['measure']} ${ing['ingredient']}'),
                                )),
                            const SizedBox(height: 20),
                            Text(
                              'Instrucciones',
                              style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              recipe.instructions,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.lato(fontSize: 16, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              );
            } else if (state is DetailError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}