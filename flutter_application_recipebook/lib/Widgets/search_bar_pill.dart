import 'package:flutter/material.dart';

class SearchBarPill extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String hintText;

  const SearchBarPill({
    super.key,
    required this.controller,
    this.onChanged,
    this.hintText = 'Search for recipes',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 64),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          prefixIcon: const Icon(
            Icons.search,
            color: Color.fromARGB(255, 113, 113, 113),
          ),
        ),
      ),
    );
  }
}
