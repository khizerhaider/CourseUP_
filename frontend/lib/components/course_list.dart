import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:course_up/components/course_card.dart';

class CourseList extends StatefulWidget {
  const CourseList({super.key, required String category});

  @override
  State<CourseList> createState() => _CourseListState();
}

class Course {
  final String title;
  final String thumbnail;

  Course({required this.title, required this.thumbnail});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(title: json['title'], thumbnail: json['thumbnail']);
  }
}

class _CourseListState extends State<CourseList> {
  late Future<List<Course>> _courses;

  @override
  void initState() {
    super.initState();
    _courses = fetchCourses();
  }

  Future<List<Course>> fetchCourses() async {
    final response = await http.get(
      //Uri.parse('http://localhost:5000/api/courses'),
      Uri.parse('http://localhost:5000/api/cloud'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  // Function to slugify the course title
  String slugify(String title) {
    return title
        .toLowerCase()
        .replaceAll(
          RegExp(r'[^a-z0-9\s-]'),
          '',
        ) // Remove non-alphanumeric characters
        .replaceAll(RegExp(r'\s+'), '-') // Replace spaces with hyphens
        .replaceAll(RegExp(r'-+'), '-') // Remove extra hyphens
        .trim(); // Remove leading and trailing hyphens
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
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No courses available.'));
          } else {
            final courses = snapshot.data!;
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                final sluggedTitle = slugify(
                  course.title,
                ); // Get the slugified title
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/courses/$sluggedTitle', // matches the route above
                      arguments: course.title,
                    );
                  },
                  child: CourseCard(
                    title: course.title,
                    thumbnailUrl: course.thumbnail,
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            );
          }
        },
      ),
    );
  }
}
