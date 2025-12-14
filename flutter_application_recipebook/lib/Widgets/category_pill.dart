import 'package:flutter/material.dart';

class CategoryPill extends StatelessWidget {
  final ImageProvider image;
  final String label;
  final double width;
  final double height;

  const CategoryPill({
    super.key,
    required this.image,
    required this.label,
    this.width = 140,
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(image: image, fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(height: 8), // space between image and label
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
