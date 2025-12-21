import 'package:flutter/material.dart';
import '../Models/recipe.dart';

class MealRecipePickerScreen extends StatelessWidget {
  final List<Recipe> recipes;

  const MealRecipePickerScreen({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Drag handle
          const SizedBox(height: 10),
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 12),

          // Title
          const Text(
            'Select a Recipe',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002A22),
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];

                return GestureDetector(
                  onTap: () => Navigator.pop(context, recipe),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(20),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // BIGGER IMAGE
                        ClipRRect(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(16),
                          ),
                          child: Image.asset(
                            recipe.imagePath,
                            width: 120,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recipe.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${recipe.cookingTime} min • ${recipe.difficulty}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Tap to add',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF002A22),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
