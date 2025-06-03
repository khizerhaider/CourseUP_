import 'package:flutter/material.dart';
import 'package:course_up/components/home_screen.dart';
import 'package:course_up/components/courseDetails/course_detail.dart';
import 'package:course_up/components/courseDetails/course_videos_page.dart';
import 'package:media_kit/media_kit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized(); // <-- IMPORTANT!
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/courseDetail': (context) {
          final slug = ModalRoute.of(context)!.settings.arguments as String;
          return CourseDetailPage(slug: slug);
        },
        '/courseVideos': (context) {
          final slug = ModalRoute.of(context)!.settings.arguments as String;
          final courseTitle =
              ModalRoute.of(context)!.settings.arguments as String;
          return CourseVideosPage(slug: slug, courseTitle: courseTitle);
        },
      },
    );
  }
}
