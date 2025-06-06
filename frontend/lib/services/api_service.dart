import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://7e58dbec-efe0-4d6b-91c7-a5ca0ae22534-00-2wkze85hmztxa.sisko.replit.dev/api';

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
