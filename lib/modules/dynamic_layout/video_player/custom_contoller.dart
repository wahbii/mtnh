import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class CustomControls extends StatelessWidget {
  final ChewieController chewieController;

  const CustomControls({required this.chewieController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.play_arrow),
            color: Colors.white,
            onPressed: () {
              chewieController.play();
            },
          ),
          IconButton(
            icon: Icon(Icons.pause),
            color: Colors.white,
            onPressed: () {
              chewieController.pause();
            },
          ),
          IconButton(
            icon: Icon(Icons.stop),
            color: Colors.white,
            onPressed: () {
              chewieController.videoPlayerController.seekTo(Duration.zero);
              chewieController.pause();
            },
          ),
        ],
      ),
    );
  }
}
