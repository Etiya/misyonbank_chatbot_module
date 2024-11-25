import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final String url;
  final bool loop;
  const Video({
    required this.loop,
    required this.url,
    super.key,
  });

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;
  @override
  void initState() {
    _videoPlayerController1 = VideoPlayerController.network(widget.url)
      ..initialize().then((value) => setState(() {}));
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
    );
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: SafeArea(
                child: Center(
                  child: _chewieController!
                          .videoPlayerController.value.isInitialized
                      ? SizedBox(
                          child: Chewie(
                            controller: _chewieController!,
                          ),
                        )
                      : const CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
            SafeArea(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
