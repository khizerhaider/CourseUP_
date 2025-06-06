import 'package:flutter/material.dart';
import 'package:course_up/components/home_screen.dart';
import 'package:course_up/components/courseDetails/course_detail.dart';
import 'package:course_up/components/courseDetails/course_videos_page.dart';
import 'package:media_kit/media_kit.dart';
import 'package:course_up/components/search_results.dart';
import 'package:course_up/components/splash/splash_screen.dart'; // <- Import it

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
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
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // <-- Start here
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        // <-- Add splash screen
        '/courseDetail': (context) {
          final slug = ModalRoute.of(context)!.settings.arguments as String;
          return CourseDetailPage(slug: slug);
        },
        '/courseVideos': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return CourseVideosPage(
            slug: args['slug'],
            courseTitle: args['courseTitle'],
          );
        },
        '/searchResults': (context) {
          final query = ModalRoute.of(context)!.settings.arguments as String;
          return SearchResultsList(query: query);
        },
      },
    );
  }
}
