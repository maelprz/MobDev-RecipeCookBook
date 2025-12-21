// Widgets/meal_slot_card.dart
import 'package:flutter/material.dart';
import '../Models/meal_plan.dart';

class MealSlotCard extends StatelessWidget {
  final String title;
  final List<MealPlanRecipe> recipes;
  final VoidCallback onAddPressed;

  const MealSlotCard({
    super.key,
    required this.title,
    required this.recipes,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF002A22),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                color: const Color(0xFF002A22),
                onPressed: onAddPressed,
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Empty state
          if (recipes.isEmpty)
            const Text(
              'No meals added yet',
              style: TextStyle(color: Colors.grey),
            ),

          // Meals list
          if (recipes.isNotEmpty)
            Column(
              children: recipes.map((mealRecipe) {
                final recipe = mealRecipe.recipe;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      // Recipe Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          recipe.imagePath,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Recipe Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recipe.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${recipe.cookingTime} min • ${recipe.difficulty}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Servings: ${mealRecipe.servings}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
