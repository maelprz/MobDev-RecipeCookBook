import 'package:flutter/material.dart';
import '../Widgets/bottom_nav_pill.dart';
import '../Widgets/search_bar_pill.dart';
import '../Widgets/filter_pill.dart';
import '../Widgets/recipe_card.dart';

class FilipinoRecipesScreen extends StatefulWidget {
  const FilipinoRecipesScreen({super.key});

  @override
  State<FilipinoRecipesScreen> createState() => _FilipinoRecipesScreenState();
}

class _FilipinoRecipesScreenState extends State<FilipinoRecipesScreen> {
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
    const categoryTitle = 'Filipino';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF002A22)),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(height: 10),
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: const [
                    RecipeCard(
                      imagePath: 'assets/home_screen/category-filipino.jpg',
                      title: 'Adobo',
                      time: '40 min',
                      difficulty: 'Medium',
                    ),
                    RecipeCard(
                      imagePath: 'assets/home_screen/category-filipino.jpg',
                      title: 'Sinigang',
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
