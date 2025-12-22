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
  /// REMOVE recipe from a slot (decrements servings if more than 1)
  void removeMeal({
    required String day,
    required String mealType,
    required Recipe recipe,
  }) {
    final currentPlan = state[day];
    if (currentPlan == null) return;

    MealPlan updatedPlan;

    List<MealPlanRecipe> updateList(List<MealPlanRecipe> list) {
      final index = list.indexWhere((r) => r.recipe.id == recipe.id);
      if (index == -1) return list;

      final updated = List<MealPlanRecipe>.from(list);
      final current = updated[index];

      if (current.servings > 1) {
        // decrement servings by 1
        updated[index] = current.copyWith(servings: current.servings - 1);
        return updated;
      } else {
        // remove recipe if only 1 serving left
        updated.removeAt(index);
        return updated;
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
