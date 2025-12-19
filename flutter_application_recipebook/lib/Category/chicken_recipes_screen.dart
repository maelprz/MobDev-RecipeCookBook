import 'package:flutter/material.dart';
import '../Widgets/bottom_nav_pill.dart';
import '../Widgets/search_bar_pill.dart';
import '../Widgets/filter_pill.dart';
import '../Widgets/recipe_card.dart';

class ChickenRecipesScreen extends StatefulWidget {
  const ChickenRecipesScreen({super.key});

  @override
  State<ChickenRecipesScreen> createState() => _ChickenRecipesScreenState();
}

class _ChickenRecipesScreenState extends State<ChickenRecipesScreen> {
  final TextEditingController searchController = TextEditingController();
  int _currentIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
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
    const categoryTitle = 'Chicken'; // change this per screen

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // Back Button
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF002A22)),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            const SizedBox(height: 10),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SearchBarPill(
                controller: searchController,
                hintText: 'Search Recipes',
                onChanged: (value) {
                  debugPrint('$categoryTitle search: $value');
                },
              ),
            ),

            const SizedBox(height: 25),

            // Category Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                categoryTitle,
                style: TextStyle(
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: const [
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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavPill(currentIndex: _currentIndex, onTap: _onNavTap),
    );
  }
}
