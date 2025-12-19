import 'package:flutter/material.dart';
import '../Widgets/bottom_nav_pill.dart';
import '../Widgets/search_bar_pill.dart';
import '../Widgets/filter_pill.dart';
import '../Widgets/recipe_card.dart';

class MexicanRecipesScreen extends StatefulWidget {
  const MexicanRecipesScreen({super.key});

  @override
  State<MexicanRecipesScreen> createState() => _MexicanRecipesScreenState();
}

class _MexicanRecipesScreenState extends State<MexicanRecipesScreen> {
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

  final List<Map<String, dynamic>> recipes = const [
    {
      'imagePath': 'assets/home_screen/category-mexican.jpg',
      'title': 'Tacos',
      'time': '20 min',
      'difficulty': 'Easy',
      'isFavorite': false,
    },
    {
      'imagePath': 'assets/home_screen/category-mexican.jpg',
      'title': 'Quesadillas',
      'time': '25 min',
      'difficulty': 'Easy',
      'isFavorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    const categoryTitle = 'Mexican';

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
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: RecipeCard(
                      imagePath: recipe['imagePath'],
                      title: recipe['title'],
                      time: recipe['time'],
                      difficulty: recipe['difficulty'],
                      isFavorite: recipe['isFavorite'],
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
