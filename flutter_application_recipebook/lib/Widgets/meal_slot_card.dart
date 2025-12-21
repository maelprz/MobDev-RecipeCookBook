import 'package:flutter/material.dart';
import '../Models/meal_plan.dart';
import '../Screens/recipe_details_screen.dart';

class MealSlotCard extends StatelessWidget {
  final String title;
  final List<MealPlanRecipe> recipes;
  final VoidCallback onAddPressed;
  final void Function(MealPlanRecipe)? onRemovePressed;

  const MealSlotCard({
    super.key,
    required this.title,
    required this.recipes,
    required this.onAddPressed,
    this.onRemovePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
                color: const Color(0xFF1D5120), // Updated Add (+) color
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
              mainAxisSize: MainAxisSize.min, // <-- prevents extra vertical space
              children: recipes.map((mealRecipe) {
                final recipe = mealRecipe.recipe;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeDetailsScreen(recipeId: recipe.id),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8), // smaller spacing
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center, // <-- align vertically center
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            recipe.imagePath,
                            width: 80, // slightly smaller
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min, // <-- prevent stretching
                            children: [
                              Text(
                                recipe.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${recipe.cookingTime} min • ${recipe.difficulty}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (onRemovePressed != null)
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            color: Colors.red,
                            onPressed: () => onRemovePressed!(mealRecipe),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
