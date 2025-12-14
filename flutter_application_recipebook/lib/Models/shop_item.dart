class ShoppingItem {
  final String name;
  final double totalQuantity;
  final String unit;
  final String category;
  final bool purchased;

  ShoppingItem({
    required this.name,
    required this.totalQuantity,
    required this.unit,
    required this.category,
    this.purchased = false,
  });

  ShoppingItem copyWith({bool? purchased}) {
    return ShoppingItem(
      name: name,
      totalQuantity: totalQuantity,
      unit: unit,
      category: category,
      purchased: purchased ?? this.purchased,
    );
  }
}
