class Ingredient {
  final String name;
  final double quantity;
  final String unit; // tsp, tbsp, g, ml, pcs
  final String category; // Produce, Dairy, Meat, Spices, etc.

  Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.category,
  });
}
