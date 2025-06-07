import 'package:course_up/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:course_up/components/home_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _refresh() async {
    // Add your data reload logic here
    // For example, re-fetch API data, update state, etc.
    print('Refreshing data...');
    await Future.delayed(const Duration(seconds: 1)); // Simulate delay
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF0F4FD,
      ), // Fixed the transparent issue too
      appBar: const CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: const HomeBody(), // Ensure HomeBody uses a scrollable widget
      ),
    );
  }
}
