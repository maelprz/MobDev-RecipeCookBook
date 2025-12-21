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

  /// ✅ ADD recipe to a specific meal slot
  void addMeal({
    required String day,
    required String mealType,
    required Recipe recipe,
  }) {
    final currentPlan = state[day] ?? const MealPlan();

    MealPlan updatedPlan;

    switch (mealType) {
      case 'breakfast':
        updatedPlan = currentPlan.copyWith(
          breakfast: [...currentPlan.breakfast, recipe],
        );
        break;

      case 'lunch':
        updatedPlan = currentPlan.copyWith(
          lunch: [...currentPlan.lunch, recipe],
        );
        break;

      case 'dinner':
        updatedPlan = currentPlan.copyWith(
          dinner: [...currentPlan.dinner, recipe],
        );
        break;

      default:
        return;
    }

    state = {...state, day: updatedPlan};
  }

  /// ❌ REMOVE recipe from a slot
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
              .where((r) => r.id != recipe.id)
              .toList(),
        );
        break;

      case 'lunch':
        updatedPlan = currentPlan.copyWith(
          lunch: currentPlan.lunch.where((r) => r.id != recipe.id).toList(),
        );
        break;

      case 'dinner':
        updatedPlan = currentPlan.copyWith(
          dinner: currentPlan.dinner.where((r) => r.id != recipe.id).toList(),
        );
        break;

      default:
        return;
    }

    state = {...state, day: updatedPlan};
  }

  /// 🧹 Clear one day
  void clearDay(String day) {
    state = {...state, day: const MealPlan()};
  }

  /// 🔄 Reset everything
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

/// 🔹 Provider
final mealPlanProvider =
    StateNotifierProvider<MealPlanNotifier, Map<String, MealPlan>>(
      (ref) => MealPlanNotifier(),
    );
