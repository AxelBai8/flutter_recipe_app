import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/search/search_bloc.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/search/search_event.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/search/search_state.dart';
import 'package:recetas_app/features/recipes/presentation/widgets/recipe_card.dart';
import 'package:recetas_app/injection_container.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SearchBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Buscar Recetas'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Ej: Chicken, Pasta, Soup...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (query) {
                  context.read<SearchBloc>().add(TextChanged(query: query));
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoaded) {
                    if (state.recipes.isEmpty) {
                      return Center(
                        child: Text(
                          'No se encontraron recetas.',
                          style: GoogleFonts.lato(fontSize: 18),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.recipes.length,
                      itemBuilder: (context, index) {
                        return RecipeCard(recipe: state.recipes[index]);
                      },
                    );
                  } else if (state is SearchError) {
                    return Center(child: Text(state.message));
                  }
                  // Estado inicial o vacío
                  return Center(
                    child: Text(
                      'Escribe para buscar una receta',
                      style: GoogleFonts.lato(fontSize: 18, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
