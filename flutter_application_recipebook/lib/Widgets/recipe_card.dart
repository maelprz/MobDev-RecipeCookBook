import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String time;
  final String difficulty;
  final bool isFavorite;

  const RecipeCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.time,
    required this.difficulty,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 120,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 13), // ~5%
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imagePath,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF002A22),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.schedule, size: 16),
                    const SizedBox(width: 4),
                    Text(time),
                    const SizedBox(width: 12),
                    const Icon(Icons.local_fire_department, size: 16),
                    const SizedBox(width: 4),
                    Text(difficulty),
                  ],
                ),
              ],
            ),
          ),
          Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
        ],
      ),
    );
  }
}
