import 'package:flutter_riverpod/flutter_riverpod.dart';

// A type alias for clarity: weekday -> list of recipe IDs
typedef MealPlan = Map<String, List<String>>;

// MealPlanNotifier handles adding/removing recipes to weekdays
class MealPlanNotifier extends StateNotifier<MealPlan> {
  MealPlanNotifier()
    : super({
        'Monday': [],
        'Tuesday': [],
        'Wednesday': [],
        'Thursday': [],
        'Friday': [],
        'Saturday': [],
        'Sunday': [],
      });

  // Add a recipe to a specific day
  void addRecipe(String day, String recipeId) {
    final dayRecipes = List<String>.from(state[day] ?? []);
    if (!dayRecipes.contains(recipeId)) {
      dayRecipes.add(recipeId);
      state = {...state, day: dayRecipes};
    }
  }

  // Remove a recipe from a specific day
  void removeRecipe(String day, String recipeId) {
    final dayRecipes = List<String>.from(state[day] ?? []);
    if (dayRecipes.contains(recipeId)) {
      dayRecipes.remove(recipeId);
      state = {...state, day: dayRecipes};
    }
  }

  // Clear all recipes from a specific day
  void clearDay(String day) {
    state = {...state, day: []};
  }

  // Reset the entire meal plan
  void resetMealPlan() {
    state = {
      'Monday': [],
      'Tuesday': [],
      'Wednesday': [],
      'Thursday': [],
      'Friday': [],
      'Saturday': [],
      'Sunday': [],
    };
  }
}

// The provider to watch in UI
final mealPlanProvider = StateNotifierProvider<MealPlanNotifier, MealPlan>(
  (ref) => MealPlanNotifier(),
);
