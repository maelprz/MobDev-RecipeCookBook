import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Providers/meal_plan_provider.dart';
import '../Widgets/bottom_nav_pill.dart';
import '../Widgets/meal_day_selector.dart';
import '../Widgets/meal_slot_card.dart';
import 'meal_recipe_picker_screen.dart';

class MealPlanScreen extends ConsumerStatefulWidget {
  const MealPlanScreen({super.key});

  @override
  ConsumerState<MealPlanScreen> createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends ConsumerState<MealPlanScreen> {
  String selectedDay = 'Monday';
  int currentIndex = 2;

  final List<String> days = const [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  Future<void> _addRecipe(BuildContext context, String mealType) async {
    final recipe = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            MealRecipePickerScreen(day: selectedDay, mealType: mealType),
      ),
    );

    if (recipe != null) {
      ref
          .read(mealPlanProvider.notifier)
          .addMeal(day: selectedDay, mealType: mealType, recipe: recipe);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealPlans = ref.watch(mealPlanProvider);
    final plan = mealPlans[selectedDay];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Meal Plan',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF002A22),
                ),
              ),
            ),

            /// Day selector
            MealDaySelector(
              days: days,
              selectedDay: selectedDay,
              onDaySelected: (day) {
                setState(() => selectedDay = day);
              },
            ),

            const SizedBox(height: 20),

            /// Meal slots
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  MealSlotCard(
                    title: 'Breakfast',
                    recipes: plan?.breakfast ?? [],
                    onAdd: () => _addRecipe(context, 'breakfast'),
                  ),
                  MealSlotCard(
                    title: 'Lunch',
                    recipes: plan?.lunch ?? [],
                    onAdd: () => _addRecipe(context, 'lunch'),
                  ),
                  MealSlotCard(
                    title: 'Dinner',
                    recipes: plan?.dinner ?? [],
                    onAdd: () => _addRecipe(context, 'dinner'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavPill(
        currentIndex: currentIndex,
        onTap: (_) {},
      ),
    );
  }
}
