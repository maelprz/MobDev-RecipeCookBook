import 'package:flutter/material.dart';

import '../Widgets/bottom_nav_pill.dart';
import '../Widgets/filter_pill.dart';
import '../Data/category_data.dart';
import '../Category/category_recipe_screen.dart';

class ViewAllCategories extends StatefulWidget {
  const ViewAllCategories({super.key});

  @override
  State<ViewAllCategories> createState() => _ViewAllCategoriesState();
}

class _ViewAllCategoriesState extends State<ViewAllCategories> {
  int _currentIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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

            const SizedBox(height: 25),

            // Categories Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Categories',
                style: TextStyle(
                  color: Color(0xFF002A22),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Filter Pills
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Wrap(
                spacing: 5,
                children: const [
                  FilterPill(label: 'Appetizer'),
                  FilterPill(label: 'Main Course'),
                  FilterPill(label: 'Snack'),
                  FilterPill(label: 'Cuisine'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Category Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];

                    return GestureDetector(
                      onTap: () {
                        // Navigate to the reusable CategoryRecipesScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CategoryRecipesScreen(
                              categoryName: category['name']!,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(category['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          alignment: Alignment.bottomLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.black54, Colors.transparent],
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category['name']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                category['count']!,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
