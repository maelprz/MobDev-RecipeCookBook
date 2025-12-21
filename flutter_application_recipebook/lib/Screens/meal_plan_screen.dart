import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Widgets/filter_pill.dart';
import '../Widgets/recipe_card.dart';
import '../Widgets/bottom_nav_pill.dart';
import '../Providers/meal_plan_provider.dart';
import '../Providers/recipe_providers.dart';
import '../Screens/recipe_details_screen.dart';

class MealPlanScreen extends ConsumerStatefulWidget {
  const MealPlanScreen({super.key});

  @override
  ConsumerState<MealPlanScreen> createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends ConsumerState<MealPlanScreen> {
  int currentIndex = 1; // Meal Plan tab

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    // TODO: navigate to other screens based on index
  }

  @override
  Widget build(BuildContext context) {
    final mealPlan = ref.watch(mealPlanProvider);
    final weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Weekly Meal Plan'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filter pills
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                FilterPill(label: 'Breakfast'),
                FilterPill(label: 'Lunch'),
                FilterPill(label: 'Dinner'),
                FilterPill(label: 'Snack'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Meal Plan per day
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: weekdays.length,
              itemBuilder: (context, index) {
                final day = weekdays[index];
                final recipesForDay = mealPlan[day] ?? [];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 140,
                      child: recipesForDay.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: recipesForDay.length,
                              itemBuilder: (context, recipeIndex) {
                                final recipeId = recipesForDay[recipeIndex];
                                final recipe = ref.watch(
                                  recipeDetailProvider(recipeId),
                                );

                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => RecipeDetailsScreen(
                                            recipeId: recipeId,
                                          ),
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      width: 300,
                                      child: RecipeCard(
                                        imagePath: recipe.imagePath,
                                        title: recipe.name,
                                        time: '${recipe.cookingTime} min',
                                        difficulty: recipe.difficulty,
                                        isFavorite:
                                            false, // since Recipe has no isFavorite yet
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Center(child: Text('No recipes added')),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavPill(
        currentIndex: currentIndex,
        onTap: onTabTapped,
      ),
    );
  }
}
