import 'package:flutter_riverpod/flutter_riverpod.dart';

class RatingsNotifier extends StateNotifier<Map<String, int>> {
  RatingsNotifier() : super({});

  void setRating(String recipeId, int stars) {
    if (stars < 1 || stars > 5) return;

    state = {
      ...state,
      recipeId: stars,
    };
  }

  int getRating(String recipeId) => state[recipeId] ?? 0;
}

final ratingsProvider =
    StateNotifierProvider<RatingsNotifier, Map<String, int>>(
  (ref) => RatingsNotifier(),
);
