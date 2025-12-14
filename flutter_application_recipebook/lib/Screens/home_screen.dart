import 'package:flutter/material.dart';
import '../Widgets/label_pill.dart';
import '../Widgets/category_pill.dart';
import '../Widgets/recommendation_pill.dart';
import '../Widgets/bottom_nav_pill.dart';
import 'view_all_categories.dart'; // 👈 NEW IMPORT

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 95),
              child: LabelPill(
                alignment: MainAxisAlignment.spaceBetween,
                text: 'Hello, DEMON LORD!',
                textSize: 25,
                icon: Icons.star,
                index: 1,
                textColor: const Color(0xFF002A22),
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 20),
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.3),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: "Search for recipes",
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 113, 113, 113),
                        fontSize: 18,
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 113, 113, 113),
                        size: 26,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Categories Header
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25),
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

                  // 👇 VIEW ALL NAVIGATION
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ViewAllCategories(),
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

            // Categories list
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    SizedBox(width: 25),
                    CategoryPill(
                      image: AssetImage('assets/home_screen/category-chicken.jpg'),
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
                      image: AssetImage('assets/home_screen/category-seafood.jpg'),
                      label: 'Seafood',
                    ),
                    SizedBox(width: 25),
                  ],
                ),
              ),
            ),

            // Recommended Header
            const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 25.0),
              child: Text(
                'Recommended',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xFF002A22),
                ),
              ),
            ),

            // Recommended list
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    SizedBox(width: 25),
                    RecommendationPill(
                      imagePath: 'assets/home_screen/category-chicken.jpg',
                      recipeName: 'Grilled Chicken',
                      details: '5 ingredients | 30 min',
                    ),
                    SizedBox(width: 15),
                    RecommendationPill(
                      imagePath: 'assets/home_screen/category-beef.jpg',
                      recipeName: 'Beef Steak',
                      details: '7 ingredients | 45 min',
                    ),
                    SizedBox(width: 25),
                    RecommendationPill(
                      imagePath: 'assets/home_screen/category-beef.jpg',
                      recipeName: 'Beef Steak',
                      details: '7 ingredients | 45 min',
                    ),
                    SizedBox(width: 25),
                    RecommendationPill(
                      imagePath: 'assets/home_screen/category-beef.jpg',
                      recipeName: 'Beef Steak',
                      details: '7 ingredients | 45 min',
                    ),
                    SizedBox(width: 25),
                    RecommendationPill(
                      imagePath: 'assets/home_screen/category-beef.jpg',
                      recipeName: 'Beef Steak',
                      details: '7 ingredients | 45 min',
                    ),
                    SizedBox(width: 25),
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
