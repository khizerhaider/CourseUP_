import 'package:course_up/components/courseDetails/course_videos_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

class CourseDetailPage extends StatelessWidget {
  final String slug;
  const CourseDetailPage({super.key, required this.slug});

  Future<Map<String, dynamic>> fetchCourseDetails() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:5000/api/courses/$slug'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load course details');
    }
  }

  // Helper function to check if thumbnail is a Cloudinary URL
  bool isCloudinaryUrl(String url) {
    return url.contains('cloudinary.com');
  }

  // Helper function to build thumbnail widget
  Widget buildThumbnail(String thumbnail) {
    if (isCloudinaryUrl(thumbnail)) {
      // Use Cloudinary URL directly
      return CachedNetworkImage(
        imageUrl: thumbnail,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
        placeholder:
            (context, url) => Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[800],
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
        errorWidget:
            (context, url, error) => Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[800],
              child: const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 50,
              ),
            ),
      );
    } else {
      // Fallback for base64 encoded images (legacy support)
      try {
        final bytes = base64Decode(thumbnail);
        return Image.memory(
          bytes,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        );
      } catch (e) {
        return Container(
          width: double.infinity,
          height: 200,
          color: Colors.grey[800],
          child: const Icon(
            Icons.image_not_supported,
            color: Colors.grey,
            size: 50,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchCourseDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFF0D0D2B),
            body: Center(
              child: CircularProgressIndicator(color: Colors.deepPurpleAccent),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: const Color(0xFF0D0D2B),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          );
        } else if (!snapshot.hasData) {
          return const Scaffold(
            backgroundColor: Color(0xFF0D0D2B),
            body: Center(
              child: Text(
                'Course not found.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        } else {
          final courseDetails = snapshot.data!;

          return Scaffold(
            backgroundColor: const Color(0xFF0D0D2B),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: kToolbarHeight + 20,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0D0D2B),
                      Color.fromARGB(255, 226, 220, 255),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.deepPurpleAccent),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFF0D0D2B),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: buildThumbnail(courseDetails['thumbnail']),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Card Section for details
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E2E48),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            courseDetails['title'],
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            courseDetails['description'],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurpleAccent,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => CourseVideosPage(
                                          slug: slug,
                                          courseTitle: courseDetails['title'],
                                        ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Start Course',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
