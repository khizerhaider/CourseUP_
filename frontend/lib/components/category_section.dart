import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:course_up/components/category_text.dart';

class CategorySection extends StatefulWidget {
  final Function(String) onCategorySelected;

  const CategorySection({super.key, required this.onCategorySelected});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  List<String> _categories = ['All']; // default category
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:5000/api/courses/categories'),
        //Uri.parse('http://localhost:5000/api/cloud/categories'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<String> fetched =
            data.map<String>((item) => item['name'].toString()).toList();
        setState(() {
          _categories = ['All', ...fetched];
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const minGap = 12.0;
    const estimatedTextWidth = 80.0;

    final totalNeededWidth =
        (_categories.length * estimatedTextWidth) +
        ((minGap) * (_categories.length - 1));
    // ignore: unused_local_variable
    final useWrap = totalNeededWidth > screenWidth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            "Courses",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 29, 17, 91),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  _categories.map((label) {
                    final isActive = label == _selectedCategory;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.only(right: 12),
                      child: AnimatedSlide(
                        duration: const Duration(milliseconds: 300),
                        offset: isActive ? Offset.zero : const Offset(0.1, 0),
                        curve: Curves.easeOut,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: 1.0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategory = label;
                              });
                              widget.onCategorySelected(label);
                            },
                            child: CategoryText(
                              label: label,
                              isSelected: isActive,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
