import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super(<String>{});

  bool isFavorite(String recipeId) {
    return state.contains(recipeId);
  }

  void toggleFavorite(String recipeId) {
    if (state.contains(recipeId)) {
      state = {...state}..remove(recipeId);
    } else {
      state = {...state, recipeId};
    }
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, Set<String>>(
  (ref) => FavoritesNotifier(),
);
