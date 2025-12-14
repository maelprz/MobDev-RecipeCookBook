import 'package:flutter/material.dart';

class RecommendationPill extends StatelessWidget {
  final String imagePath;
  final String recipeName;
  final String details; // e.g., "5 ingredients | 30 min"

  const RecommendationPill({
    super.key,
    required this.imagePath,
    required this.recipeName,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 200,
          height: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.favorite_border, color: Colors.red),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          recipeName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(details, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}
