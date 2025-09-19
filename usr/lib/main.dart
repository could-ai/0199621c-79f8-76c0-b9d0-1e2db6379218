import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brainrot App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const BrainrotPage(),
    );
  }
}

class BrainrotPage extends StatefulWidget {
  const BrainrotPage({super.key});

  @override
  State<BrainrotPage> createState() => _BrainrotPageState();
}

class _BrainrotPageState extends State<BrainrotPage> {
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;

  @override
  void initState() {
    super.initState();
    _controller1 = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, and play the video.
        setState(() {});
        _controller1.play();
        _controller1.setLooping(true);
        _controller1.setVolume(0);
      });

    _controller2 = VideoPlayerController.networkUrl(Uri.parse(
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4'))
      ..initialize().then((_) {
        setState(() {});
        _controller2.play();
        _controller2.setLooping(true);
        _controller2.setVolume(0);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: _controller1.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller1.value.aspectRatio,
                    child: VideoPlayer(_controller1),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          Expanded(
            child: _controller2.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller2.value.aspectRatio,
                    child: VideoPlayer(_controller2),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
  }
}
