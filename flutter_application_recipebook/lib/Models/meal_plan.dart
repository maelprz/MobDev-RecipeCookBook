import 'recipe.dart';

class MealPlanRecipe {
  final Recipe recipe;
  final int servings;

  const MealPlanRecipe({required this.recipe, this.servings = 1});

  MealPlanRecipe copyWith({int? servings}) {
    return MealPlanRecipe(recipe: recipe, servings: servings ?? this.servings);
  }
}

class MealPlan {
  final List<MealPlanRecipe> breakfast;
  final List<MealPlanRecipe> lunch;
  final List<MealPlanRecipe> dinner;

  const MealPlan({
    this.breakfast = const [],
    this.lunch = const [],
    this.dinner = const [],
  });

  MealPlan copyWith({
    List<MealPlanRecipe>? breakfast,
    List<MealPlanRecipe>? lunch,
    List<MealPlanRecipe>? dinner,
  }) {
    return MealPlan(
      breakfast: breakfast ?? this.breakfast,
      lunch: lunch ?? this.lunch,
      dinner: dinner ?? this.dinner,
    );
  }
}
