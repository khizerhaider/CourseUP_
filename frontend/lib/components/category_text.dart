import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color selectedColor;

  const CategoryText({
    super.key,
    required this.label,
    required this.isSelected,
    this.selectedColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color:
            isSelected
                ? const Color.fromARGB(
                  255,
                  29,
                  17,
                  91,
                ) // Deep purple theme color
                : const Color(0xFFE0E7FF), // Light background
        borderRadius: BorderRadius.circular(30),
        boxShadow:
            isSelected
                ? [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ]
                : [],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color:
              isSelected
                  ? Colors.white
                  : const Color(
                    0xFF1E1E1E,
                  ), // Adjusted text color for better contrast
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
