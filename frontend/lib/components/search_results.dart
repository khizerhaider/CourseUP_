import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:course_up/components/course_card.dart';
import 'package:course_up/components/course_list.dart';

class SearchResultsList extends StatefulWidget {
  final String query;
  const SearchResultsList({super.key, required this.query});

  @override
  State<SearchResultsList> createState() => _SearchResultsListState();
}

class _SearchResultsListState extends State<SearchResultsList> {
  late Future<List<Course>> _courses;

  @override
  void initState() {
    super.initState();
    _courses = fetchSearchResults(widget.query);
  }

  Future<List<Course>> fetchSearchResults(String query) async {
    final url =
        'https://7e58dbec-efe0-4d6b-91c7-a5ca0ae22534-00-2wkze85hmztxa.sisko.replit.dev/api/courses/search?q=${Uri.encodeComponent(query)}';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load search results');
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
    return Scaffold(
      backgroundColor: const Color(0x00f0f4fd),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: kToolbarHeight,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D0D2B), Color.fromARGB(255, 226, 220, 255)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.deepPurpleAccent),
      ),

      body: FutureBuilder<List<Course>>(
        future: _courses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No results found.'));
          } else {
            final courses = snapshot.data!;
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: courses.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
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
            );
          }
        },
      ),
    );
  }
}
