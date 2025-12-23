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
        _currentIndex = result ?? 0;
      });
      return;
    }

    if (index == 3) {
      final result = await Navigator.push<int>(
        context,
        MaterialPageRoute(builder: (_) => const FavoritesListScreen()),
      );

      setState(() {
        _currentIndex = result ?? 0;
      });
      return;
    }

    setState(() => _currentIndex = index);
  }

  /// 🔑 SAFELY get recipe ID by name
  String? _getRecipeIdByName(String name) {
    final recipes = ref.read(recipesDataProvider);
    try {
      return recipes.firstWhere((r) => r.name == name).id;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(filteredRecipesProvider);

    // 1️⃣ Recommended foods with numFave
    final recommendedFoods = [
      {
        'name': 'Grilled Chicken',
        'image': 'assets/home_screen/recommendation-grilledChicken.jpg',
        'details': '2 ingredients | 40 min',
        'numFave': 1700,
      },
      {
        'name': 'Carbonara',
        'image': 'assets/home_screen/recommendation-carBonaRa.jpg',
        'details': '2 ingredients | 30 min',
        'numFave': 980,
      },
      {
        'name': 'Beef Steak',
        'image': 'assets/home_screen/recommendation-beefSteak.jpg',
        'details': '3 ingredients | 40 min',
        'numFave': 1500, // try changing this to see sorting
      },
      {
        'name': 'Salmon Steak',
        'image': 'assets/home_screen/recommendation-salmon.jpg',
        'details': '6 ingredients | 35 min',
        'numFave': 750,
      },
      {
        'name': 'Ramen',
        'image': 'assets/recipes/r27.jpg',
        'details': '1 ingredient | 45 min',
        'numFave': 600,
      },
    ];

    // 2️⃣ Sort descending by numFave
    recommendedFoods.sort(
      (a, b) => (b['numFave'] as int).compareTo(a['numFave'] as int),
    ); // highest first

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
                  children: [
                    const SizedBox(width: 25),

                    // 3️⃣ Build RecommendationPills dynamically
                    ...recommendedFoods.map((food) {
                      final id = _getRecipeIdByName(food['name'] as String);
                      return Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: RecommendationPill(
                          imagePath: food['image'] as String,
                          recipeName: food['name'] as String,
                          details: food['details'] as String,
                          numFave: food['numFave'] as int,
                          onTap: () {
                            if (id == null) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    RecipeDetailsScreen(recipeId: id),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),

                    const SizedBox(width: 25),
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
