import 'ingredient.dart';

class Recipe {
  final String id;
  final String name;
  final String imagePath;
  final List<Ingredient> ingredients;
  final List<String> steps;

  final String mealType; // breakfast, lunch, dinner, snack
  final String cuisine; // asian, italian, american, etc.
  final int cookingTime; // in minutes
  final String difficulty; // easy, medium, hard

  Recipe({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.ingredients,
    required this.steps,
    required this.mealType,
    required this.cuisine,
    required this.cookingTime,
    required this.difficulty,
  });
}
