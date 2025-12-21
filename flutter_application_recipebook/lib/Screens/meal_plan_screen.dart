// Screens/meal_plan_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Providers/meal_plan_provider.dart';
import '../Providers/recipe_providers.dart';
import '../Widgets/bottom_nav_pill.dart';
import '../Widgets/meal_slot_card.dart';

import 'home_screen.dart';
import 'favorites_list_screen.dart';
import 'meal_recipe_picker_screen.dart';

class MealPlanScreen extends ConsumerStatefulWidget {
  const MealPlanScreen({super.key});

  @override
  ConsumerState<MealPlanScreen> createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends ConsumerState<MealPlanScreen> {
  String selectedDay = 'Monday';
  final int _currentIndex = 1;

  final List<String> days = const [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  void _onNavTap(int index) {
    if (index == _currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (_) => false,
        );
        break;
      case 3:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const FavoritesListScreen()),
          (_) => false,
        );
        break;
    }
  }

  void _pickRecipe(String mealType) async {
    final recipes = ref.read(recipesDataProvider);

    final selected = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: MealRecipePickerScreen(recipes: recipes),
        );
      },
    );

    if (selected != null) {
      ref
          .read(mealPlanProvider.notifier)
          .addMeal(day: selectedDay, mealType: mealType, recipe: selected);
    }
  }

  void _removeRecipe(String mealType, dynamic mealPlanRecipe) {
    ref.read(mealPlanProvider.notifier).removeMeal(
          day: selectedDay,
          mealType: mealType,
          recipe: mealPlanRecipe.recipe,
        );
  }

  @override
  Widget build(BuildContext context) {
    final mealPlan = ref.watch(mealPlanProvider)[selectedDay]!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF002A22)),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            );
          },
        ),
        title: const Text(
          'Meal Plan',
          style: TextStyle(
            color: Color(0xFF002A22),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: days.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (_, index) {
                  final day = days[index];
                  final isSelected = day == selectedDay;

                  return GestureDetector(
                    onTap: () => setState(() => selectedDay = day),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF1D5120)
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        day.substring(0, 3),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  MealSlotCard(
                    title: 'Breakfast',
                    recipes: mealPlan.breakfast,
                    onAddPressed: () => _pickRecipe('breakfast'),
                    onRemovePressed: (recipe) =>
                        _removeRecipe('breakfast', recipe),
                  ),
                  MealSlotCard(
                    title: 'Lunch',
                    recipes: mealPlan.lunch,
                    onAddPressed: () => _pickRecipe('lunch'),
                    onRemovePressed: (recipe) => _removeRecipe('lunch', recipe),
                  ),
                  MealSlotCard(
                    title: 'Dinner',
                    recipes: mealPlan.dinner,
                    onAddPressed: () => _pickRecipe('dinner'),
                    onRemovePressed: (recipe) => _removeRecipe('dinner', recipe),
                  ),
                  const SizedBox(height: 20),
                ],
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
