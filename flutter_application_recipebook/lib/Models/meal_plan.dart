import '../Models/recipe.dart';

class MealPlan {
  final List<Recipe> breakfast;
  final List<Recipe> lunch;
  final List<Recipe> dinner;

  const MealPlan({
    this.breakfast = const [],
    this.lunch = const [],
    this.dinner = const [],
  });

  MealPlan copyWith({
    List<Recipe>? breakfast,
    List<Recipe>? lunch,
    List<Recipe>? dinner,
  }) {
    return MealPlan(
      breakfast: breakfast ?? this.breakfast,
      lunch: lunch ?? this.lunch,
      dinner: dinner ?? this.dinner,
    );
  }
}
