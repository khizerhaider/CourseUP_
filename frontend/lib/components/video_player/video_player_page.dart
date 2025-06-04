import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerPage({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late final Player player;
  late final VideoController controller;
  bool isFullScreen = false;

  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    player = Player();
    controller = VideoController(player);
    player.open(Media(widget.videoUrl)).then((_) {
      setState(() {
        isInitialized = true;
      });
    });
  }

  @override
  void dispose() {
    _exitFullScreen(); // Ensure orientation resets
    player.dispose();
    super.dispose();
  }

  void _toggleFullScreen() {
    setState(() {
      isFullScreen = !isFullScreen;
    });

    if (isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      _exitFullScreen();
    }
  }

  void _exitFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D2B),
      appBar:
          isFullScreen
              ? null
              : AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: kToolbarHeight,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF0D0D2B),
                        Color.fromARGB(255, 226, 220, 255),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                iconTheme: const IconThemeData(color: Colors.deepPurpleAccent),
              ),
      body: Center(
        child: Stack(
          children: [
            Center(
              child:
                  isInitialized
                      ? AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Video(controller: controller),
                      )
                      : const CircularProgressIndicator(),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: IconButton(
                icon: Icon(
                  isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: _toggleFullScreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
