import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "COURSE UP",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Montserrat',
            ),
          ),
          SizedBox(height: 8),
          Text(
            "What do you want to learn?",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontFamily: 'Montserrat',
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
