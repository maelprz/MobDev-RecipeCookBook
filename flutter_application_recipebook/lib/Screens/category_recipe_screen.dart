import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Providers/recipe_providers.dart';
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
        // Go back to HomeScreen directly
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
        // Navigate to FavoritesListScreen, removing intermediate screens
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
    final allRecipes = ref.watch(recipesDataProvider);

    // Filter recipes by category and search query
    final filteredRecipes = allRecipes.where((recipe) {
      final matchesCategory =
          recipe.cuisine.toLowerCase() == categoryTitle.toLowerCase();
      final matchesSearch = recipe.name
          .toLowerCase()
          .contains(searchController.text.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // Back Button → always goes back to HomeScreen
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
                hintText: 'Search Recipes',
                onChanged: (_) => setState(() {}),
              ),
            ),

            const SizedBox(height: 10),

            // Category Title
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

            // Filter Pills
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: const [
                  FilterPill(label: 'Time'),
                  SizedBox(width: 10),
                  FilterPill(label: 'Difficulty'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Recipe Cards
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = filteredRecipes[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                RecipeDetailsScreen(recipeId: recipe.id),
                          ),
                        );
                      },
                      child: RecipeCard(
                        imagePath: recipe.imagePath,
                        title: recipe.name,
                        time: '${recipe.cookingTime} min',
                        difficulty: recipe.difficulty,
                        isFavorite: false,
                      ),
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
