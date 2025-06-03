// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';

// class CourseCard extends StatelessWidget {
//   final String title;
//   final String thumbnailBase64;

//   const CourseCard({
//     super.key,
//     required this.title,
//     required this.thumbnailBase64,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Uint8List? imageBytes;

//     try {
//       final String cleanBase64 = thumbnailBase64.split(',').last;
//       imageBytes = base64Decode(cleanBase64);
//     } catch (e) {
//       debugPrint('Error decoding base64 image: $e');
//     }

//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       shadowColor: Colors.black12,
//       color: Theme.of(context).cardColor,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(16),

//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: const BorderRadius.vertical(
//                 top: Radius.circular(16),
//               ),
//               child:
//                   imageBytes != null
//                       ? Image.memory(
//                         imageBytes,
//                         height: 140,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Container(
//                             height: 140,
//                             color: Color(0xFFE0E7FF), //Colors.grey[200],
//                             child: const Center(
//                               child: Icon(
//                                 Icons.image_not_supported,
//                                 size: 40,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           );
//                         },
//                       )
//                       : Container(
//                         height: 140,
//                         color: Colors.grey[200],
//                         child: const Center(
//                           child: Icon(
//                             Icons.image_not_supported,
//                             size: 40,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
//               child: Text(
//                 title,
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 18,
//                 ),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String thumbnailUrl; // Now using URL

  const CourseCard({
    super.key,
    required this.title,
    required this.thumbnailUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.black12,
      color: Theme.of(context).cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                thumbnailUrl,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 140,
                    color: const Color(0xFFE0E7FF),
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
