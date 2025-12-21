import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Providers/recipe_providers.dart';
import '../Models/recipe.dart';

class MealRecipePickerScreen extends ConsumerWidget {
  final String day;
  final String mealType;

  const MealRecipePickerScreen({
    super.key,
    required this.day,
    required this.mealType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(recipesDataProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Select ${_capitalize(mealType)}')),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];

          return ListTile(
            leading: Image.asset(
              recipe.imagePath,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(recipe.name),
            subtitle: Text('${recipe.cookingTime} min • ${recipe.difficulty}'),
            trailing: const Icon(Icons.add),
            onTap: () {
              Navigator.pop<Recipe>(context, recipe);
            },
          );
        },
      ),
    );
  }

  String _capitalize(String value) {
    return value[0].toUpperCase() + value.substring(1);
  }
}
