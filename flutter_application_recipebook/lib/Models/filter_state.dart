enum SortOption { none, cookingTime, difficulty }

class FilterState {
  final String? difficulty;
  final int? maxCookingTime;
  final SortOption sortOption;

  FilterState({
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
      difficulty: difficulty ?? this.difficulty,
      maxCookingTime: maxCookingTime ?? this.maxCookingTime,
      sortOption: sortOption ?? this.sortOption,
    );
  }
}
