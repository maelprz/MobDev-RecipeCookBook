import 'package:flutter/material.dart';

import '../Widgets/bottom_nav_pill.dart';
import '../Widgets/search_bar_pill.dart';
import '../Widgets/filter_pill.dart';
import 'home_screen.dart';

class FavoritesListScreen extends StatefulWidget {
  const FavoritesListScreen({super.key});

  @override
  State<FavoritesListScreen> createState() => _FavoritesListScreenState();
}

class _FavoritesListScreenState extends State<FavoritesListScreen> {
  final TextEditingController searchController = TextEditingController();
  int _currentIndex = 3; // ❤️ Favorites

  void _onNavTap(int index) {
    if (index == _currentIndex) return;

    setState(() => _currentIndex = index);

    if (index == 0) {
      // Go directly to HomeScreen, removing current route
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // Back Button → always goes to HomeScreen
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

            // Search Bar (UI only)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SearchBarPill(
                controller: searchController,
                hintText: 'Search Favorites',
                onChanged: (_) {}, // no functionality yet
              ),
            ),

            const SizedBox(height: 10),

            // Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Favorites',
                style: TextStyle(
                  color: Color(0xFF002A22),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Filter Pills (UI only)
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

            // Placeholder for favorite recipes
            const Expanded(
              child: Center(
                child: Text(
                  'Your favorite recipes will appear here',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
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
