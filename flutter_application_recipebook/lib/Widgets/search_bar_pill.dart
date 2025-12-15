import 'package:flutter/material.dart';

class SearchBarPill extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;

  const SearchBarPill({
    super.key,
    required this.controller,
    this.hintText = 'Search Recipes',
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 113, 113, 113),
              fontSize: 18,
            ),
            border: InputBorder.none,
            prefixIcon: const Icon(
              Icons.search,
              color: Color.fromARGB(255, 113, 113, 113),
              size: 26,
            ),
          ),
        ),
      ),
    );
  }
}
