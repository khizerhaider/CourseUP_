import 'package:flutter/material.dart';
import 'category_section.dart'; // Assuming you moved it to its own file
import 'course_list.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  String selectedCategory = "All";

  void handleCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategorySection(onCategorySelected: handleCategorySelected),
        Expanded(child: CourseList(category: selectedCategory)),
      ],
    );
  }
}
