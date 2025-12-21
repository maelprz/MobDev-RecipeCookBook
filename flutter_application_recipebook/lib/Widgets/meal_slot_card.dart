import 'package:flutter/material.dart';
import '../Models/recipe.dart';

class MealSlotCard extends StatelessWidget {
  final String title;
  final List<Recipe> recipes;
  final VoidCallback onAdd;

  const MealSlotCard({
    super.key,
    required this.title,
    required this.recipes,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
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
                onPressed: onAdd,
              ),
            ],
          ),

          /// Empty state
          if (recipes.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'No meals added',
                style: TextStyle(color: Colors.grey),
              ),
            ),

          /// Recipe list
          if (recipes.isNotEmpty)
            ...recipes.map(
              (recipe) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  recipe.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  '${recipe.cookingTime} min • ${recipe.difficulty}',
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
        ],
      ),
    );
  }
}
