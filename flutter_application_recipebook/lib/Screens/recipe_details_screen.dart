import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Providers/recipe_providers.dart';
import '../Providers/favorites_provider.dart';
import '../Providers/ratings_provider.dart';
import '../Widgets/bottom_nav_pill.dart';
import 'home_screen.dart';
import 'favorites_list_screen.dart';

class RecipeDetailsScreen extends ConsumerStatefulWidget {
  final String recipeId;

  const RecipeDetailsScreen({super.key, required this.recipeId});

  @override
  ConsumerState<RecipeDetailsScreen> createState() =>
      _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends ConsumerState<RecipeDetailsScreen> {
  int _currentIndex = 0;

  void _onNavTap(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);

    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
        break;
      case 1:
        debugPrint('Meal Plan tapped');
        break;
      case 2:
        debugPrint('Cart tapped');
        break;
      case 3:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const FavoritesListScreen()),
          (route) => false,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final recipe = ref.watch(recipeDetailProvider(widget.recipeId));
    final favorites = ref.watch(favoritesProvider);
    final isFavorite = favorites.contains(widget.recipeId);
    final ratings = ref.watch(ratingsProvider);
    final currentRating = ratings[widget.recipeId] ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE HEADER
              Stack(
                children: [
                  Image.asset(
                    recipe.imagePath,
                    height: 410,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: _CircleButton(
                      icon: Icons.arrow_back,
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: _CircleButton(
                      icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                      iconColor: isFavorite ? Colors.red : Colors.black,
                      onTap: () {
                        ref
                            .read(favoritesProvider.notifier)
                            .toggleFavorite(widget.recipeId);
                      },
                    ),
                  ),
                ],
              ),

              // RECIPE CARD
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Transform.translate(
                  offset: const Offset(0, -80), // safe negative offset
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 20),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          recipe.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF002A22),
                          ),
                        ),
                        Text(
                          '${recipe.ingredients.length} ingredients',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.schedule, size: 16),
                            const SizedBox(width: 4),
                            Text('${recipe.cookingTime} min'),
                            const SizedBox(width: 12),
                            const Icon(Icons.bar_chart, size: 16),
                            const SizedBox(width: 4),
                            Text(recipe.difficulty),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            final starIndex = index + 1;
                            return IconButton(
                              icon: Icon(
                                starIndex <= currentRating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                              ),
                              onPressed: () {
                                ref
                                    .read(ratingsProvider.notifier)
                                    .setRating(widget.recipeId, starIndex);
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // INGREDIENTS
              Transform.translate(
                offset: const Offset(0, -65),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _SectionCard(
                    title: 'Ingredients',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: recipe.ingredients.map((ingredient) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            '• ${ingredient.name} (${ingredient.quantity}${ingredient.unit})',
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),

              // INSTRUCTIONS
              Transform.translate(
                offset: const Offset(0, -70),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _SectionCard(
                    title: 'Instructions',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: recipe.steps.asMap().entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text('${entry.key + 1}. ${entry.value}'),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavPill(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _CircleButton({
    required this.icon,
    required this.onTap,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 20,
        child: Icon(icon, color: iconColor),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 20),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002A22),
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
