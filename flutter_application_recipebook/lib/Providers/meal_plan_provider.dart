// Providers/meal_plan_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/meal_plan.dart';
import '../Models/recipe.dart';

class MealPlanNotifier extends StateNotifier<Map<String, MealPlan>> {
  MealPlanNotifier()
    : super({
        'Monday': const MealPlan(),
        'Tuesday': const MealPlan(),
        'Wednesday': const MealPlan(),
        'Thursday': const MealPlan(),
        'Friday': const MealPlan(),
        'Saturday': const MealPlan(),
        'Sunday': const MealPlan(),
      });

  /// ADD recipe to a specific meal slot (prevents duplicates, increments servings)
  void addMeal({
    required String day,
    required String mealType,
    required Recipe recipe,
  }) {
    final currentPlan = state[day] ?? const MealPlan();

    MealPlan updatedPlan;

    List<MealPlanRecipe> updateList(List<MealPlanRecipe> list) {
      final index = list.indexWhere((r) => r.recipe.id == recipe.id);
      if (index >= 0) {
        final updated = List<MealPlanRecipe>.from(list);
        updated[index] = updated[index].copyWith(
          servings: updated[index].servings + 1,
        );
        return updated;
      } else {
        return [...list, MealPlanRecipe(recipe: recipe)];
      }
    }

    switch (mealType) {
      case 'breakfast':
        updatedPlan = currentPlan.copyWith(
          breakfast: updateList(currentPlan.breakfast),
        );
        break;
      case 'lunch':
        updatedPlan = currentPlan.copyWith(
          lunch: updateList(currentPlan.lunch),
        );
        break;
      case 'dinner':
        updatedPlan = currentPlan.copyWith(
          dinner: updateList(currentPlan.dinner),
        );
        break;
      default:
        return;
    }

    state = {...state, day: updatedPlan};
  }

  /// REMOVE recipe from a slot
  void removeMeal({
    required String day,
    required String mealType,
    required Recipe recipe,
  }) {
    final currentPlan = state[day];
    if (currentPlan == null) return;

    MealPlan updatedPlan;

    switch (mealType) {
      case 'breakfast':
        updatedPlan = currentPlan.copyWith(
          breakfast: currentPlan.breakfast
              .where((r) => r.recipe.id != recipe.id)
              .toList(),
        );
        break;
      case 'lunch':
        updatedPlan = currentPlan.copyWith(
          lunch: currentPlan.lunch
              .where((r) => r.recipe.id != recipe.id)
              .toList(),
        );
        break;
      case 'dinner':
        updatedPlan = currentPlan.copyWith(
          dinner: currentPlan.dinner
              .where((r) => r.recipe.id != recipe.id)
              .toList(),
        );
        break;
      default:
        return;
    }

    state = {...state, day: updatedPlan};
  }

  /// Clear one day
  void clearDay(String day) {
    state = {...state, day: const MealPlan()};
  }

  /// Reset everything
  void resetMealPlan() {
    state = {
      'Monday': const MealPlan(),
      'Tuesday': const MealPlan(),
      'Wednesday': const MealPlan(),
      'Thursday': const MealPlan(),
      'Friday': const MealPlan(),
      'Saturday': const MealPlan(),
      'Sunday': const MealPlan(),
    };
  }
}

/// Provider
final mealPlanProvider =
    StateNotifierProvider<MealPlanNotifier, Map<String, MealPlan>>(
      (ref) => MealPlanNotifier(),
    );
