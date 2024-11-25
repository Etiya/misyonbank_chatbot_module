import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({
    super.key,
    required this.url,
  });
  final String url;

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  late VideoPlayerController _videoPlayerController1;
  ChewieAudioController? _chewieAudioController;
  @override
  void initState() {
    _videoPlayerController1 = VideoPlayerController.network(widget.url)
      ..initialize().then((value) => setState(() {}));
    _chewieAudioController = ChewieAudioController(
      videoPlayerController: _videoPlayerController1,
    );
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieAudioController?.dispose();
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
                  child: _chewieAudioController!
                          .videoPlayerController.value.isInitialized
                      ? SizedBox(
                          child: ChewieAudio(
                            controller: _chewieAudioController!,
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
