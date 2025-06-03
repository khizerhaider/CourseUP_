import 'package:flutter/material.dart';

class CusSearchBar extends StatelessWidget {
  const CusSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [Color(0xFF1B1B3A), Color(0xFF3A3A6A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: const Color(0xFF3A3A6A).withOpacity(0.4),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: "Search courses...",
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
