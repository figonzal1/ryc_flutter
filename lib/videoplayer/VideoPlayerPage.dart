import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:video_player/video_player.dart';

var logger = Logger();

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key, required this.title});

  final String title;

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  //Remote video
  late VideoPlayerController _remoteVideoController;
  late Future<void> _remoteVideoPlayerFuture;

  //Local video
  late VideoPlayerController _localVideoController;
  late Future<void> _localVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _remoteVideoController = VideoPlayerController.networkUrl(Uri.parse(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"));

    _remoteVideoPlayerFuture = _remoteVideoController.initialize();
    _remoteVideoController.setLooping(true);

    _localVideoController =
        VideoPlayerController.asset("assets/videos/test_coopeuch.mp4");
    _localVideoPlayerFuture = _localVideoController.initialize();
    _localVideoController.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _remoteVideoController.dispose();
    _localVideoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text(
              "Remote video",
              style: TextStyle(fontSize: 24),
            ),
            FutureBuilder(
              future: _remoteVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _remoteVideoController.value.aspectRatio,
                    child: VideoPlayer(_remoteVideoController),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            MaterialButton(
                color: Theme.of(context).colorScheme.inversePrimary,
                child: Icon(
                  _remoteVideoController.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
                onPressed: () {
                  setState(() {
                    if (_remoteVideoController.value.isPlaying) {
                      _remoteVideoController.pause();
                    } else {
                      _remoteVideoController.play();
                      _localVideoController.pause();
                    }
                  });
                }),
            const Padding(padding: EdgeInsets.only(top: 10)),
            const Text(
              "Local video",
              style: TextStyle(fontSize: 24),
            ),
            FutureBuilder(
              future: _localVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _localVideoController.value.aspectRatio,
                    child: VideoPlayer(_localVideoController),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            MaterialButton(
                color: Theme.of(context).colorScheme.inversePrimary,
                child: Icon(
                  _localVideoController.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
                onPressed: () {
                  setState(() {
                    if (_localVideoController.value.isPlaying) {
                      _localVideoController.pause();
                    } else {
                      _localVideoController.play();
                      _remoteVideoController.pause();
                    }
                  });
                })
          ],
        ),
      ),
    );
  }
}
