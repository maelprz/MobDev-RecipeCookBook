import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Providers/recipe_providers.dart';
import '../Widgets/label_pill.dart';
import '../Widgets/category_pill.dart';
import '../Widgets/recommendation_pill.dart';
import '../Widgets/bottom_nav_pill.dart';
import '../Widgets/search_bar_pill.dart';

import 'view_all_categories.dart';
import 'category_recipe_screen.dart';
import 'recipe_details_screen.dart';
import 'favorites_list_screen.dart';
import '../Screens/meal_plan_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  bool _showDropdown = false;

  int _currentIndex = 0; // 🏠 Home

  void _onNavTap(int index) async {
    if (index == _currentIndex) return;
    if (index == 1) {
      final result = await Navigator.push<int>(
        context,
        MaterialPageRoute(builder: (_) => const MealPlanScreen()),
      );

      setState(() {
        _currentIndex = result ?? 0; // fallback to Home
      });

      return;
    }

    // ❤️ Favorites
    if (index == 3) {
      final result = await Navigator.push<int>(
        context,
        MaterialPageRoute(builder: (_) => const FavoritesListScreen()),
      );

      setState(() {
        _currentIndex = result ?? 0; // fallback to Home
      });

      return;
    }

    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(filteredRecipesProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 95),
              child: LabelPill(
                alignment: MainAxisAlignment.spaceBetween,
                text: 'Hello, DEMON LORD!',
                textSize: 25,
                icon: Icons.star,
                index: 1,
                textColor: const Color(0xFF002A22),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                children: [
                  SearchBarPill(
                    controller: searchController,
                    onChanged: (value) {
                      ref.read(searchQueryProvider.notifier).state = value;
                      setState(() => _showDropdown = value.isNotEmpty);
                    },
                  ),

                  if (_showDropdown && searchResults.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      constraints: const BoxConstraints(maxHeight: 220),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha(64),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: searchResults.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final recipe = searchResults[index];

                          return ListTile(
                            title: Text(recipe.name),
                            subtitle: Text(
                              '${recipe.ingredients.length} ingredients • ${recipe.cookingTime} min',
                            ),
                            onTap: () {
                              setState(() => _showDropdown = false);
                              FocusScope.of(context).unfocus();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      RecipeDetailsScreen(recipeId: recipe.id),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF002A22),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ViewAllCategories(),
                        ),
                      );
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 25),
                    _category(
                      context,
                      'Chicken',
                      'assets/home_screen/category-chicken.jpg',
                    ),
                    _category(
                      context,
                      'Pork',
                      'assets/home_screen/category-pork.jpg',
                    ),
                    _category(
                      context,
                      'Beef',
                      'assets/home_screen/category-beef.jpg',
                    ),
                    _category(
                      context,
                      'Seafood',
                      'assets/home_screen/category-seafood.jpg',
                    ),
                    const SizedBox(width: 25),
                  ],
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 25, top: 25),
              child: Text(
                'Recommended',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    SizedBox(width: 25),
                    RecommendationPill(
                      imagePath:
                          'assets/home_screen/recommendation-grilledChicken.jpg',
                      recipeName: 'Grilled Chicken',
                      details: '5 ingredients | 30 min',
                    ),
                    SizedBox(width: 15),
                    RecommendationPill(
                      imagePath:
                          'assets/home_screen/recommendation-carBonaRa.jpg',
                      recipeName: 'Carbonara',
                      details: '8 ingredients | 25 min',
                    ),
                    SizedBox(width: 15),
                    RecommendationPill(
                      imagePath:
                          'assets/home_screen/recommendation-beefSteak.jpg',
                      recipeName: 'Beef Steak',
                      details: '7 ingredients | 40 min',
                    ),
                    SizedBox(width: 25),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavPill(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }

  Widget _category(BuildContext context, String name, String asset) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CategoryRecipesScreen(categoryName: name),
            ),
          );
        },
        child: CategoryPill(image: AssetImage(asset), label: name),
      ),
    );
  }
}
