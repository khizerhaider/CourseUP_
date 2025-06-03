import 'package:flutter/material.dart';

class HighlightedCourse extends StatelessWidget {
  const HighlightedCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/banner1.png'),
          fit: BoxFit.cover,
        ),
        color: const Color(0xFF6C63FF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
