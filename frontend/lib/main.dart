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

// // Home Screen
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 10, 6, 83),
//       appBar: const CustomAppBar(),
//       body: const HomeBody(),
//     );
//   }
// }

// // Custom AppBar
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       leading: const Icon(Icons.menu, color: Colors.white),
//       actions: const [
//         Padding(
//           padding: EdgeInsets.only(right: 16.0),
//           child: CircleAvatar(
//             backgroundImage: AssetImage('assets/images/avatar.png'),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

// // Home Body
// class HomeBody extends StatelessWidget {
//   const HomeBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Color.fromARGB(255, 10, 6, 83),
//             Color.fromARGB(255, 118, 95, 218),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       padding: const EdgeInsets.all(16.0),
//       child: ListView(
//         children: const [
//           HeaderSection(),
//           SearchBar(),
//           HighlightedCourse(),
//           CategorySection(),
//           CourseGrid(),
//         ],
//       ),
//     );
//   }
// }

// // Header Section
// class HeaderSection extends StatelessWidget {
//   const HeaderSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         Text(
//           "COURSE UP",
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         SizedBox(height: 8),
//         Text(
//           "What do you want to learn?",
//           style: TextStyle(fontSize: 16, color: Colors.grey),
//         ),
//         SizedBox(height: 16),
//       ],
//     );
//   }
// }

// // Search Bar
// class SearchBar extends StatelessWidget {
//   const SearchBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black,
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: "Search...",
//           prefixIcon: const Icon(Icons.search),
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Highlighted Course
// class HighlightedCourse extends StatelessWidget {
//   const HighlightedCourse({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         image: const DecorationImage(
//           image: AssetImage('assets/images/avatar.png'),
//           fit: BoxFit.cover,
//         ),
//         color: const Color(0xFF6C63FF),
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black,
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text(
//                   "BEST COURSES AVAILABLE AT COURSE UP!",
//                   style: TextStyle(
//                     color: Color.fromARGB(255, 2, 57, 101),
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 Text(
//                   "User Experience Class",
//                   style: TextStyle(
//                     color: Color.fromARGB(255, 2, 57, 101),
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.white,
//               foregroundColor: const Color(0xFF6C63FF),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             child: const Text("See Class"),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Category Section
// class CategorySection extends StatelessWidget {
//   const CategorySection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Course",
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         const SizedBox(height: 8),
//         ShaderMask(
//           shaderCallback: (bounds) {
//             return const LinearGradient(
//               colors: [
//                 Color.fromARGB(255, 203, 189, 251),
//                 Color.fromARGB(255, 3, 0, 18),
//               ],
//             ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
//           },
//           blendMode: BlendMode.srcIn,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: const [
//                 CategoryText(label: "All"),
//                 CategoryText(label: "Design"),
//                 CategoryText(label: "Programming"),
//                 CategoryText(label: "UI/UX"),
//                 CategoryText(label: "View All"),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
// }

// // Category Text
// class CategoryText extends StatelessWidget {
//   final String label;

//   const CategoryText({super.key, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 9.0),
//       child: Text(
//         label,
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 16,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }

// // Course Grid
// class CourseGrid extends StatelessWidget {
//   const CourseGrid({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final courses = [
//       CourseCard(
//         title: "Photoshop Course",
//         rating: 5.0,
//         duration: "5h 15m",
//         color: Colors.purple.shade100,
//       ),
//       CourseCard(
//         title: "3D Design",
//         rating: 4.6,
//         duration: "10h 30m",
//         color: Colors.orange.shade100,
//       ),
//       CourseCard(
//         title: "JavaScript Course",
//         rating: 4.6,
//         duration: "10h 30m",
//         color: Colors.orange.shade100,
//       ),
//       CourseCard(
//         title: "Python Course",
//         rating: 4.6,
//         duration: "10h 30m",
//         color: Colors.orange.shade100,
//       ),
//       CourseCard(
//         title: "HTML Course",
//         rating: 4.6,
//         duration: "10h 30m",
//         color: Colors.orange.shade100,
//       ),
//       CourseCard(
//         title: "CSS Course",
//         rating: 4.6,
//         duration: "10h 30m",
//         color: Colors.orange.shade100,
//       ),
//     ];

//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//         maxCrossAxisExtent: 300,
//         mainAxisSpacing: 16,
//         crossAxisSpacing: 16,
//         childAspectRatio: 3 / 2,
//       ),
//       itemCount: courses.length,
//       itemBuilder: (context, index) {
//         return courses[index];
//       },
//     );
//   }
// }

// // Course Card
// class CourseCard extends StatelessWidget {
//   final String title;
//   final double rating;
//   final String duration;
//   final Color color;

//   const CourseCard({
//     super.key,
//     required this.title,
//     required this.rating,
//     required this.duration,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         double iconSize = constraints.maxWidth * 0.15;
//         double fontSize = constraints.maxWidth * 0.06;

//         return Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(color: Colors.black12, offset: const Offset(0, 4)),
//             ],
//           ),
//           child: Row(
//             children: [
//               Icon(Icons.book, size: iconSize, color: Colors.black54),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: fontSize,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.star,
//                           size: 14,
//                           color: Colors.yellow.shade700,
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           "$rating",
//                           style: TextStyle(fontSize: fontSize * 0.8),
//                         ),
//                         const SizedBox(width: 12),
//                         const Icon(
//                           Icons.access_time,
//                           size: 14,
//                           color: Colors.grey,
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           duration,
//                           style: TextStyle(fontSize: fontSize * 0.8),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
