import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Providers/favorites_provider.dart';
import '../Providers/recipe_providers.dart';
import '../Models/filter_state.dart';
import '../Widgets/bottom_nav_pill.dart';
import '../Widgets/search_bar_pill.dart';
import '../Widgets/filter_pill.dart';
import '../Widgets/recipe_card.dart';
import 'home_screen.dart';
import 'recipe_details_screen.dart';

class FavoritesListScreen extends ConsumerStatefulWidget {
  const FavoritesListScreen({super.key});

  @override
  ConsumerState<FavoritesListScreen> createState() =>
      _FavoritesListScreenState();
}

class _FavoritesListScreenState extends ConsumerState<FavoritesListScreen> {
  final TextEditingController searchController = TextEditingController();
  int _currentIndex = 3;

  void _onNavTap(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);

    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
        break;
      case 1:
        debugPrint('Meal Plan tapped');
        break;
      case 2:
        debugPrint('Cart tapped');
        break;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allRecipes = ref.watch(filteredRecipesProvider);
    final favoriteIds = ref.watch(favoritesProvider);

    // Filter only favorite recipes
    List favoriteRecipes =
        allRecipes.where((r) => favoriteIds.contains(r.id)).toList();

    // Apply search query
    final searchQuery = ref.watch(searchQueryProvider);
    if (searchQuery.isNotEmpty) {
      favoriteRecipes = favoriteRecipes
          .where(
            (r) => r.name.toLowerCase().contains(searchQuery.toLowerCase()),
          )
          .toList();
    }

    // Apply sort option
    final sortOption = ref.watch(recipeFiltersProvider).sortOption;
    favoriteRecipes.sort((a, b) {
      switch (sortOption) {
        case SortOption.cookingTime:
          return a.cookingTime.compareTo(b.cookingTime);
        case SortOption.difficulty:
          return a.difficulty.compareTo(b.difficulty);
        case SortOption.none:
          return 0;
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // Back button
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF002A22)),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false,
                  );
                },
              ),
            ),

            const SizedBox(height: 5),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SearchBarPill(
                controller: searchController,
                hintText: 'Search Favorites',
                onChanged: (value) {
                  ref.read(searchQueryProvider.notifier).state = value;
                },
              ),
            ),

            const SizedBox(height: 10),

            // Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Favorites',
                style: TextStyle(
                  color: Color(0xFF002A22),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Filter Pills
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  FilterPill(
                    label: 'Time',
                    onTap: () {
                      ref
                          .read(recipeFiltersProvider.notifier)
                          .setSortOption(SortOption.cookingTime);
                    },
                  ),
                  const SizedBox(width: 10),
                  FilterPill(
                    label: 'Difficulty',
                    onTap: () {
                      ref
                          .read(recipeFiltersProvider.notifier)
                          .setSortOption(SortOption.difficulty);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Favorites List
            Expanded(
              child: favoriteRecipes.isEmpty
                  ? const Center(
                      child: Text(
                        'No favorites yet ❤️',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      itemCount: favoriteRecipes.length,
                      itemBuilder: (context, index) {
                        final recipe = favoriteRecipes[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: RecipeCard(
                            imagePath: recipe.imagePath,
                            title: recipe.name,
                            time: '${recipe.cookingTime} min',
                            difficulty: recipe.difficulty,
                            isFavorite: favoriteIds.contains(recipe.id),
                            onFavoriteTap: () {
                              ref
                                  .read(favoritesProvider.notifier)
                                  .toggleFavorite(recipe.id);
                            },
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      RecipeDetailsScreen(recipeId: recipe.id),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavPill(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
