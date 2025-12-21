enum SortOption { none, cookingTime, difficulty }

class FilterState {
  final String? mealType;
  final String? cuisine;
  final String? difficulty;
  final int? maxCookingTime;
  final SortOption sortOption;

  FilterState({
    this.mealType,
    this.cuisine,
    this.difficulty,
    this.maxCookingTime,
    this.sortOption = SortOption.none,
  });

  FilterState copyWith({
    String? mealType,
    String? cuisine,
    String? difficulty,
    int? maxCookingTime,
    SortOption? sortOption,
  }) {
    return FilterState(
      mealType: mealType ?? this.mealType,
      cuisine: cuisine ?? this.cuisine,
      difficulty: difficulty ?? this.difficulty,
      maxCookingTime: maxCookingTime ?? this.maxCookingTime,
      sortOption: sortOption ?? this.sortOption,
    );
  }
}
