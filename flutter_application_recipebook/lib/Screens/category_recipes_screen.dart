import 'package:flutter/material.dart';
import '../Widgets/bottom_nav_pill.dart';
import '../Widgets/search_bar_pill.dart';
import '../Widgets/filter_pill.dart';
import '../Widgets/recipe_card.dart';

class CategoryRecipeScreen extends StatefulWidget {
  final String categoryTitle;

  const CategoryRecipeScreen({super.key, required this.categoryTitle});

  @override
  State<CategoryRecipeScreen> createState() => _CategoryRecipeScreenState();
}

class _CategoryRecipeScreenState extends State<CategoryRecipeScreen> {
  final TextEditingController searchController = TextEditingController();
  int _currentIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        debugPrint('Home tapped');
        Navigator.pop(context);
        break;
      case 1:
        debugPrint('Meal Plan tapped');
        break;
      case 2:
        debugPrint('Cart tapped');
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
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // Back Button
                    IconButton(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                    ),

                    const SizedBox(height: 10),

                    // Search Bar
                    SearchBarPill(
                      controller: searchController,
                      hintText: 'Search Recipes',
                      onChanged: (value) {
                        debugPrint('Category search: $value');
                      },
                    ),

                    const SizedBox(height: 20),

                    // Category Title
                    Text(
                      widget.categoryTitle,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF002A22),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Filter Pills
                    Row(
                      children: [
                        FilterPill(label: 'Time'),
                        const SizedBox(width: 10),
                        FilterPill(label: 'Difficulty'),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Recipe Cards
                    RecipeCard(
                      imagePath: 'assets/home_screen/category-chicken.jpg',
                      title: 'Garlic Butter Chicken Thighs',
                      time: '25 min',
                      difficulty: 'Easy',
                      isFavorite: true,
                    ),
                    RecipeCard(
                      imagePath: 'assets/home_screen/category-chicken.jpg',
                      title: 'Chicken Teriyaki',
                      time: '20 min',
                      difficulty: 'Easy',
                    ),
                    RecipeCard(
                      imagePath: 'assets/home_screen/category-chicken.jpg',
                      title: 'Crispy Fried Chicken',
                      time: '45 min',
                      difficulty: 'Easy',
                    ),
                    RecipeCard(
                      imagePath: 'assets/home_screen/category-chicken.jpg',
                      title: 'Honey Buffalo Wings',
                      time: '50 min',
                      difficulty: 'Medium',
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Navigation
            BottomNavPill(currentIndex: _currentIndex, onTap: _onNavTap),
          ],
        ),
      ),
    );
  }
}
