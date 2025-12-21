import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Data/recipe_data.dart';
import '../Models/recipe.dart';
import '../Models/filter_state.dart';

/// 🔹 Mock recipe data
final recipesDataProvider = Provider<List<Recipe>>((ref) {
  return recipesData;
});

/// 🔹 Search query
final searchQueryProvider = StateProvider<String>((ref) => '');

/// 🔹 Filters & sorting state
final recipeFiltersProvider =
    StateNotifierProvider<RecipeFiltersNotifier, FilterState>((ref) {
      return RecipeFiltersNotifier();
    });

class RecipeFiltersNotifier extends StateNotifier<FilterState> {
  RecipeFiltersNotifier() : super(FilterState());

  void setSortOption(SortOption option) {
    state = state.copyWith(sortOption: option);
  }

  void setDifficulty(String? difficulty) {
    state = state.copyWith(difficulty: difficulty);
  }

  void setMaxCookingTime(int? time) {
    state = state.copyWith(maxCookingTime: time);
  }

  void clearFilters() {
    state = FilterState();
  }
}

/// 🔹 Filtered + searched + sorted recipes (COMPUTED)
final filteredRecipesProvider = Provider<List<Recipe>>((ref) {
  final allRecipes = ref.watch(recipesDataProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final filters = ref.watch(recipeFiltersProvider);

  // 1️⃣ Filtering + search
  List<Recipe> results = allRecipes.where((recipe) {
    final matchesSearch =
        query.isEmpty ||
        recipe.name.toLowerCase().contains(query) ||
        recipe.ingredients.any((i) => i.name.toLowerCase().contains(query));

    final matchesDifficulty =
        filters.difficulty == null || recipe.difficulty == filters.difficulty;

    final matchesTime =
        filters.maxCookingTime == null ||
        recipe.cookingTime <= filters.maxCookingTime!;

    return matchesSearch && matchesDifficulty && matchesTime;
  }).toList();

  // 2️⃣ Sorting
  switch (filters.sortOption) {
    case SortOption.cookingTime:
      results.sort((a, b) => a.cookingTime.compareTo(b.cookingTime));
      break;

    case SortOption.difficulty:
      const difficultyOrder = {'Easy': 1, 'Medium': 2, 'Hard': 3};

      results.sort(
        (a, b) => (difficultyOrder[a.difficulty] ?? 0).compareTo(
          difficultyOrder[b.difficulty] ?? 0,
        ),
      );
      break;

    case SortOption.none:
      break;
  }

  return results;
});

/// 🔹 Recipe detail (AUTO DISPOSE – rubric requirement)
final recipeDetailProvider = Provider.family.autoDispose<Recipe, String>((
  ref,
  recipeId,
) {
  final recipes = ref.watch(recipesDataProvider);
  return recipes.firstWhere((recipe) => recipe.id == recipeId);
});

/// 🔹 Safe nullable variant
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
