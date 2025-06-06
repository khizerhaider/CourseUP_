import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../video_player/video_player_page.dart'; // Import the VideoPlayerPage
import 'dart:convert';

class CourseVideosPage extends StatelessWidget {
  final String slug;
  final String courseTitle;

  const CourseVideosPage({
    super.key,
    required this.slug,
    required this.courseTitle,
  });

  Future<List<Map<String, dynamic>>> fetchCourseVideos() async {
    final response = await http.get(
      Uri.parse(
        'https://7e58dbec-efe0-4d6b-91c7-a5ca0ae22534-00-2wkze85hmztxa.sisko.replit.dev/api/courses/$slug/videos',
      ),
    );
    print('Response status: ${response.body}');
    if (response.statusCode == 200) {
      final List<dynamic> videos = jsonDecode(response.body);
      final List<Map<String, dynamic>> videoList =
          videos.map((video) => video as Map<String, dynamic>).toList();

      videoList.sort((a, b) {
        int extractSerial(String title) {
          final regex = RegExp(r'\((\d+)\)$');
          final match = regex.firstMatch(title);
          return match != null
              ? int.parse(match.group(1)!)
              : 9999; // Put non-numbered last
        }

        return extractSerial(a['title']).compareTo(extractSerial(b['title']));
      });

      return videoList;
    } else {
      throw Exception('Failed to load course videos');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D2B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D2B),
        iconTheme: const IconThemeData(
          color: Colors.deepPurpleAccent, // Back arrow color
        ),
        elevation: 0,
        title: Text(
          courseTitle,
          style: const TextStyle(
            color: Colors.deepPurpleAccent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchCourseVideos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No videos available.',
                style: TextStyle(color: Colors.white70),
              ),
            );
          } else {
            final videos = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.02,
                  ),
                  child: const Text(
                    'Course Content',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                    ),
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      final video = videos[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B1B3A),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(screenWidth * 0.04),
                          leading: Container(
                            width: screenWidth * 0.14,
                            height: screenWidth * 0.14,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E2E48),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.play_circle_fill,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          title: Text(
                            '${index + 1}. ${video['title']}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth * 0.042,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            video['description'],
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Colors.white70,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => VideoPlayerPage(
                                      videoUrl: video['videoUrl'],
                                    ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
