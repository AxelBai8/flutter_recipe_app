import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/recipe_bloc.dart';
import '../bloc/recipe_event.dart';
import '../bloc/recipe_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  late RecipeBloc _recipeBloc;

  @override
  void initState() {
    super.initState();
    _recipeBloc = context.read<RecipeBloc>();
    _recipeBloc.add(FetchRecipes());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      _recipeBloc.add(FetchRecipes());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScrollExtent * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildList(List recipes, bool hasReachedMax) {
    return ListView.separated(
      controller: _scrollController,
      itemCount: hasReachedMax ? recipes.length : recipes.length + 1,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        if (index >= recipes.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final recipe = recipes[index];
        return ListTile(
          leading: Image.network(recipe.imageUrl, width: 50, fit: BoxFit.cover),
          title: Text(recipe.title),
          onTap: () {
            // TODO: Navegar a detalle
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recetas')),
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state is RecipeInitial || state is RecipeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RecipeLoaded) {
            return _buildList(state.recipes, state.hasReachedMax);
          } else if (state is RecipeError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
