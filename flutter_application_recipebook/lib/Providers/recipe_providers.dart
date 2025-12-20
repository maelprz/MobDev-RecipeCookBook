import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Data/recipe_data.dart';
import '../Models/recipe.dart';

final recipesDataProvider = Provider<List<Recipe>>((ref) {
  return recipesData;
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredRecipesProvider = Provider<List<Recipe>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final allRecipes = ref.watch(recipesDataProvider);

  if (query.isEmpty) return [];

  return allRecipes.where((recipe) {
    final nameMatch = recipe.name.toLowerCase().contains(query);
    final ingredientMatch = recipe.ingredients.any(
      (ingredient) => ingredient.name.toLowerCase().contains(query),
    );
    return nameMatch || ingredientMatch;
  }).toList();
});

final recipeDetailProvider = Provider.family.autoDispose<Recipe, String>((
  ref,
  recipeId,
) {
  final recipes = ref.watch(recipesDataProvider);
  return recipes.firstWhere((recipe) => recipe.id == recipeId);
});

final recipeByIdProvider = Provider.family.autoDispose<Recipe?, String>((
  ref,
  id,
) {
  final recipes = ref.watch(recipesDataProvider);

  try {
    return recipes.firstWhere((r) => r.id == id);
  } catch (_) {
    return null;
  }
});
