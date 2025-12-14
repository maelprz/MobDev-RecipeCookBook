import 'package:flutter_application_recipebook/Models/recipe.dart';

class MealPlan {
  final Recipe? breakfast;
  final Recipe? lunch;
  final Recipe? dinner;

  MealPlan({this.breakfast, this.lunch, this.dinner});

  MealPlan copyWith({Recipe? breakfast, Recipe? lunch, Recipe? dinner}) {
    return MealPlan(
      breakfast: breakfast ?? this.breakfast,
      lunch: lunch ?? this.lunch,
      dinner: dinner ?? this.dinner,
    );
  }
}
