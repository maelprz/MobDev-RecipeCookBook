import 'package:flutter/material.dart';
import '../Widgets/label_pill.dart';
import '../Widgets/category_pill.dart';
import '../Widgets/recommendation_pill.dart'; // Import RecommendationPill

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();

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
                text: 'Hello, Mel Stephen',
                textSize: 25,
                icon: Icons.star,
                index: 1,
                textColor: Colors.black,
              ),
            ),

            // **Search bar with TextField**
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
                      color: Colors.grey.withOpacity(0.3),
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
                children: const [
                  Text(
                    'Categories',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(
                      color: Color.fromARGB(255, 29, 81, 32),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            // Categories horizontal list
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 25),
                    CategoryPill(
                      image: AssetImage('assets/category-chicken.jpg'),
                      label: 'Chicken',
                    ),
                    const SizedBox(width: 15),
                    CategoryPill(
                      image: AssetImage('assets/category-pork.jpg'),
                      label: 'Pork',
                    ),
                    const SizedBox(width: 15),
                    CategoryPill(
                      image: AssetImage('assets/category-beef.jpg'),
                      label: 'Beef',
                    ),
                    const SizedBox(width: 15),
                    CategoryPill(
                      image: AssetImage('assets/category-seafood.jpg'),
                      label: 'Seafood',
                    ),
                    const SizedBox(width: 25),
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
                  color: Colors.black,
                ),
              ),
            ),

            // Recommended horizontal list
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    SizedBox(width: 25),
                    RecommendationPill(
                      imagePath: 'assets/category-chicken.jpg',
                      recipeName: 'Grilled Chicken',
                      details: '5 ingredients | 30 min',
                    ),
                    SizedBox(width: 15),
                    RecommendationPill(
                      imagePath: 'assets/category-beef.jpg',
                      recipeName: 'Beef Steak',
                      details: '7 ingredients | 45 min',
                    ),
                    SizedBox(width: 25),
                    RecommendationPill(
                      imagePath: 'assets/category-beef.jpg',
                      recipeName: 'Beef Steak',
                      details: '7 ingredients | 45 min',
                    ),
                    SizedBox(width: 25),
                    RecommendationPill(
                      imagePath: 'assets/category-beef.jpg',
                      recipeName: 'Beef Steak',
                      details: '7 ingredients | 45 min',
                    ),
                    SizedBox(width: 25),
                    RecommendationPill(
                      imagePath: 'assets/category-beef.jpg',
                      recipeName: 'Beef Steak',
                      details: '7 ingredients | 45 min',
                    ),
                    SizedBox(width: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
