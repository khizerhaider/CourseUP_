import 'package:course_up/components/course_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:course_up/components/course_card.dart';
//import 'package:course_up/components/category_section.dart';

class CourseList extends StatefulWidget {
  final String category;

  const CourseList({super.key, required this.category});

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  late Future<List<Course>> _courses;

  @override
  void didUpdateWidget(covariant CourseList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category != widget.category) {
      setState(() {
        _courses = fetchCourses(widget.category);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _courses = fetchCourses(widget.category);
  }

  Future<List<Course>> fetchCourses(String category) async {
    final url =
        category.toLowerCase() == 'all'
            ? 'https://7e58dbec-efe0-4d6b-91c7-a5ca0ae22534-00-2wkze85hmztxa.sisko.replit.dev/api/courses'
            : 'https://7e58dbec-efe0-4d6b-91c7-a5ca0ae22534-00-2wkze85hmztxa.sisko.replit.dev/api/courses?category=${Uri.encodeComponent(category)}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  String slugify(String title) {
    return title
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<List<Course>>(
        future: _courses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No courses available.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          } else {
            final courses = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final inAnimation = Tween<Offset>(
                    begin: const Offset(1, 0), // Slide in from right
                    end: Offset.zero,
                  ).animate(animation);

                  final outAnimation = Tween<Offset>(
                    begin: Offset.zero,
                    end: const Offset(-1, 0), // Slide out to left
                  ).animate(animation);

                  return SlideTransition(
                    position:
                        child.key == ValueKey(widget.category)
                            ? inAnimation
                            : outAnimation,
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },

                child: ListView.separated(
                  key: ValueKey(widget.category), // Important for switching
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    final sluggedTitle = slugify(course.title);

                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/courseDetail',
                          arguments: sluggedTitle,
                        );
                      },
                      child: CourseCard(
                        title: course.title,
                        thumbnailUrl: course.thumbnail,
                        description: course.description,
                      ),
                    );
                  },
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 16),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
