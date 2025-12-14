import 'package:flutter/material.dart';
import '../Widgets/bottom_nav_pill.dart';

class ViewAllCategories extends StatefulWidget {
  const ViewAllCategories({super.key});

  @override
  State<ViewAllCategories> createState() => _ViewAllCategoriesState();
}

class _ViewAllCategoriesState extends State<ViewAllCategories> {
  int _currentIndex = 0;
  final TextEditingController searchController = TextEditingController();

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

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF002A22)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'All Categories',
          style: TextStyle(
            color: Color(0xFF002A22),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // 🔍 Search bar
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

          const SizedBox(height: 20),

          // 📦 Categories Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GridView.builder(
                itemCount: 10,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade200,
                    ),
                    child: const Center(
                      child: Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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

      bottomNavigationBar: BottomNavPill(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
