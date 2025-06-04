import 'package:flutter/material.dart';

class CusSearchBar extends StatefulWidget {
  const CusSearchBar({super.key});

  @override
  State<CusSearchBar> createState() => _CusSearchBarState();
}

class _CusSearchBarState extends State<CusSearchBar> {
  final TextEditingController _controller = TextEditingController();

  void _onSubmitted(String query) {
    if (query.trim().isEmpty) return;

    Navigator.pushNamed(context, '/searchResults', arguments: query.trim());
  }

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
            color: const Color(0xFF3A3A6A).withOpacity(0.4),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
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
        onSubmitted: _onSubmitted,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
