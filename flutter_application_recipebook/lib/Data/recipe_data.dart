import 'dart:math';

import '../Models/recipe.dart';
import '../Models/ingredient.dart';

final _random = Random();

final List<String> mealTypes = [
  'Breakfast',
  'Lunch',
  'Dinner',
  'Appetizer',
  'Dessert',
  'Soup',
  'Snack',
];

final List<String> cuisines = [
  'Chicken',
  'Pork',
  'Beef',
  'Seafood',
  'Italian',
  'Filipino',
];

final List<String> difficulties = ['Easy', 'Medium', 'Hard'];

final List<String> recipeNames = [
  'Grilled Chicken',
  'Beef Steak',
  'Pork Adobo',
  'Chicken Curry',
  'Seafood Pasta',
  'Garlic Shrimp',
  'Chicken Salad',
  'Fried Pork',
  'Beef Stir Fry',
  'Creamy Pasta',
  'Chicken Soup',
  'Tomato Soup',
  'Chocolate Cake',
  'Fruit Smoothie',
  'Fried Rice',
  'Chicken Wings',
  'Beef Burger',
  'Shrimp Tacos',
  'Pork BBQ',
  'Garlic Bread',
];

final List<Ingredient> ingredientPool = [
  Ingredient(name: 'Chicken', quantity: 200, unit: 'g', category: 'Meat'),
  Ingredient(name: 'Beef', quantity: 200, unit: 'g', category: 'Meat'),
  Ingredient(name: 'Pork', quantity: 200, unit: 'g', category: 'Meat'),
  Ingredient(name: 'Shrimp', quantity: 150, unit: 'g', category: 'Seafood'),
  Ingredient(name: 'Garlic', quantity: 2, unit: 'cloves', category: 'Produce'),
  Ingredient(name: 'Onion', quantity: 1, unit: 'pcs', category: 'Produce'),
  Ingredient(name: 'Salt', quantity: 1, unit: 'tsp', category: 'Spices'),
  Ingredient(name: 'Pepper', quantity: 0.5, unit: 'tsp', category: 'Spices'),
  Ingredient(name: 'Oil', quantity: 2, unit: 'tbsp', category: 'Oil'),
  Ingredient(name: 'Tomato', quantity: 1, unit: 'pcs', category: 'Produce'),
];

List<Ingredient> _randomIngredients() {
  final shuffled = List<Ingredient>.from(ingredientPool)..shuffle();
  return shuffled.take(5).toList();
}

List<String> _randomSteps(String recipeName) {
  return [
    'Prepare ingredients for $recipeName.',
    'Cook according to recipe instructions.',
    'Serve and enjoy.',
  ];
}

final List<Recipe> recipesData = List.generate(50, (index) {
  final name = recipeNames[index % recipeNames.length];

  return Recipe(
    id: 'r${index + 1}',
    name: name,
    imagePath:
        'assets/category-${cuisines[index % cuisines.length].toLowerCase()}.jpg',
    ingredients: _randomIngredients(),
    steps: _randomSteps(name),
    mealType: mealTypes[_random.nextInt(mealTypes.length)],
    cuisine: cuisines[_random.nextInt(cuisines.length)],
    cookingTime: 15 + _random.nextInt(46),
    difficulty: difficulties[_random.nextInt(difficulties.length)],
  );
});
