import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/recipe_list_bloc.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/recipe_list_event.dart';
import 'package:recetas_app/features/recipes/presentation/bloc/recipe_list_state.dart';
import 'package:recetas_app/features/recipes/presentation/pages/search_page.dart';
import 'package:recetas_app/features/recipes/presentation/widgets/loading_recipe_card.dart';
import 'package:recetas_app/features/recipes/presentation/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<RecipeListBloc>().add(GetInitialRecipes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas del Mundo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SearchPage()));
            },
          ),
        ],
      ),
      body: BlocBuilder<RecipeListBloc, RecipeListState>(
        builder: (context, state) {
          if (state is Empty) {
            return const Center(child: Text('Iniciando...'));
          }
          if (state is Loading) {
            // Usamos nuestro widget de carga con Shimmer
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => const LoadingRecipeCard(),
            );
          }
          if (state is Loaded) {
            if (state.recipes.isEmpty) {
              return const Center(child: Text('No se encontraron recetas.'));
            }
            return ListView.builder(
              controller: _scrollController,
              // Sumamos 1 para el indicador de carga al final
              itemCount: state.hasReachedMax
                  ? state.recipes.length
                  : state.recipes.length + 1,
              itemBuilder: (context, index) {
                // Si es el último item y no hemos llegado al final, mostramos el loader
                if (index >= state.recipes.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                // Si no, mostramos la tarjeta de receta
                return RecipeCard(recipe: state.recipes[index]);
              },
            );
          }
          if (state is Error) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Algo salió mal.'));
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  // Esta función se llama cada vez que el usuario hace scroll
  void _onScroll() {
    if (_isBottom) {
      context.read<RecipeListBloc>().add(FetchMoreRecipes());
    }
  }

  // Comprueba si el usuario ha llegado al final de la lista
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // Dejamos un umbral para que cargue un poco antes de llegar al final
    return currentScroll >= (maxScroll * 0.9);
  }
}
