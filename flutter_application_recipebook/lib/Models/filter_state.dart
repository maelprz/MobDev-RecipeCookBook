class FilterState {
  final String? mealType;
  final String? cuisine;
  final String? difficulty;
  final int? maxCookingTime;

  FilterState({
    this.mealType,
    this.cuisine,
    this.difficulty,
    this.maxCookingTime,
  });

  FilterState copyWith({
    String? mealType,
    String? cuisine,
    String? difficulty,
    int? maxCookingTime,
  }) {
    return FilterState(
      mealType: mealType ?? this.mealType,
      cuisine: cuisine ?? this.cuisine,
      difficulty: difficulty ?? this.difficulty,
      maxCookingTime: maxCookingTime ?? this.maxCookingTime,
    );
  }
}
