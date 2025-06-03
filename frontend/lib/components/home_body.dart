import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:course_up/components/header.dart';
import 'package:course_up/components/cus_search_bar.dart';
import 'package:course_up/components/highlighted_course.dart';
import 'package:course_up/components/category_section.dart';
import 'package:course_up/components/course_grid.dart'; // assumed to be CourseList

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String selectedCategory = "All";

  void onCategorySelected(String category) {
    if (kDebugMode) {
      print("User selected: $category");
    }
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromARGB(0, 219, 230, 255)),
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const CusSearchBar(),
          const HighlightedCourse(),
          CategorySection(onCategorySelected: onCategorySelected),
          CourseList(category: selectedCategory), // now dynamic
        ],
      ),
    );
  }
}
