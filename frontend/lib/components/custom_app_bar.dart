import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: kToolbarHeight + 20,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D0D2B), Color.fromARGB(255, 226, 220, 255)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Icon(Icons.menu, color: Color.fromARGB(255, 224, 223, 255)),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
