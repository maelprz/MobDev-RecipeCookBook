import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Widgets/label_pill.dart';
import '../Widgets/category_pill.dart';
import '../Widgets/recommendation_pill.dart';
import '../Widgets/bottom_nav_pill.dart';
import '../Widgets/search_bar_pill.dart';
import 'view_all_categories.dart';
import '../Providers/recipe_providers.dart'; // <-- import your providers

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  int _currentIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        debugPrint('Home tapped');
        break;
      case 1:
        debugPrint('Meal Plan tapped');
        break;
      case 2:
        debugPrint('Cart / Grocery List tapped');
        break;
      case 3:
        debugPrint('Favorites tapped');
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
    // Watch filtered recipes based on search query
    final filteredRecipes = ref.watch(filteredRecipesProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
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

            // Search Bar
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
              child: SearchBarPill(
                controller: searchController,
                hintText: 'Search for recipes',
                onChanged: (value) {
                  ref.read(searchQueryProvider.notifier).state = value;
                },
              ),
            ),

            // Categories Header
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      color: Color(0xFF002A22),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
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
                        color: Color(0xFF002A22),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Categories List (unchanged)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    SizedBox(width: 25),
                    CategoryPill(
                      image: AssetImage(
                        'assets/home_screen/category-chicken.jpg',
                      ),
                      label: 'Chicken',
                    ),
                    SizedBox(width: 15),
                    CategoryPill(
                      image: AssetImage('assets/home_screen/category-pork.jpg'),
                      label: 'Pork',
                    ),
                    SizedBox(width: 15),
                    CategoryPill(
                      image: AssetImage('assets/home_screen/category-beef.jpg'),
                      label: 'Beef',
                    ),
                    SizedBox(width: 15),
                    CategoryPill(
                      image: AssetImage(
                        'assets/home_screen/category-seafood.jpg',
                      ),
                      label: 'Seafood',
                    ),
                    SizedBox(width: 25),
                  ],
                ),
              ),
            ),

            // Recommended Header
            const Padding(
              padding: EdgeInsets.only(left: 25, top: 25),
              child: Text(
                'Recommended',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xFF002A22),
                ),
              ),
            ),

            // Recommended List (dynamic)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 25),
                    ...filteredRecipes.map(
                      (recipe) => Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: RecommendationPill(
                          imagePath: recipe.imagePath,
                          recipeName: recipe.name,
                          details:
                              '${recipe.ingredients.length} ingredients | ${recipe.cookingTime} min',
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
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
