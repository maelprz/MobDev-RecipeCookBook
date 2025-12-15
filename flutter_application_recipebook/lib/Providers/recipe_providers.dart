import 'package:flutter_application_recipebook/Data/recipe_data.dart';
import 'package:flutter_application_recipebook/Models/recipe.dart';
//import 'package:flutter_application_recipebook/Models/ingredient.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recipesDataProvider = Provider<List<Recipe>>((ref) {
  return recipesData;
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredRecipesProvider = Provider<List<Recipe>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final allRecipes = ref.watch(recipesDataProvider);

  if (query.isEmpty) return allRecipes;

  return allRecipes.where((recipe) {
    final nameMatch = recipe.name.toLowerCase().contains(query);
    final ingredientMatch = recipe.ingredients.any(
      (ingredient) => ingredient.name.toLowerCase().contains(query),
    );
    return nameMatch || ingredientMatch;
  }).toList();
});
