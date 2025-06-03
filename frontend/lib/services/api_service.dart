import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api';

  // Fetch all courses
  static Future<List<dynamic>> fetchCourses() async {
    final response = await http.get(Uri.parse('$baseUrl/courses'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load courses');
    }
  }

  // Fetch videos for a specific course
  static Future<Map<String, dynamic>> fetchCourseDetails(
    String courseId,
  ) async {
    final response = await http.get(Uri.parse('$baseUrl/courses/$courseId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load course details');
    }
  }
}
