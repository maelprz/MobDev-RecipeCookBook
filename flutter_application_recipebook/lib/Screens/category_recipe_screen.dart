import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Providers/recipe_providers.dart';
import '../Providers/favorites_provider.dart';
import '../Models/filter_state.dart';
import '../Widgets/bottom_nav_pill.dart';
import '../Widgets/search_bar_pill.dart';
import '../Widgets/filter_pill.dart';
import '../Widgets/recipe_card.dart';
import 'recipe_details_screen.dart';
import 'favorites_list_screen.dart';
import 'home_screen.dart';

class CategoryRecipesScreen extends ConsumerStatefulWidget {
  final String categoryName;

  const CategoryRecipesScreen({super.key, required this.categoryName});

  @override
  ConsumerState<CategoryRecipesScreen> createState() =>
      _CategoryRecipesScreenState();
}

class _CategoryRecipesScreenState extends ConsumerState<CategoryRecipesScreen> {
  final TextEditingController searchController = TextEditingController();
  int _currentIndex = 0;

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
      case 3:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const FavoritesListScreen()),
          (route) => false,
        );
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
    final categoryTitle = widget.categoryName;

    final recipes = ref.watch(filteredRecipesProvider);

    final categoryRecipes = recipes.where((recipe) {
      return recipe.cuisine.toLowerCase() == categoryTitle.toLowerCase();
    }).toList();

    final favoriteIds = ref.watch(favoritesProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // ⬅ Back to Home
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

            // 🔍 Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SearchBarPill(
                controller: searchController,
                hintText: 'Search Recipes',
                onChanged: (value) {
                  ref.read(searchQueryProvider.notifier).state = value;
                },
              ),
            ),

            const SizedBox(height: 10),

            // 🏷 Category Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                categoryTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF002A22),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 🎛 SORT FILTER PILLS
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

            // 🍽 Recipe List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                itemCount: categoryRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = categoryRecipes[index];
                  final isFavorite = favoriteIds.contains(recipe.id);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: RecipeCard(
                      imagePath: recipe.imagePath,
                      title: recipe.name,
                      time: '${recipe.cookingTime} min',
                      difficulty: recipe.difficulty,
                      isFavorite: isFavorite,
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

      bottomNavigationBar: BottomNavPill(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
