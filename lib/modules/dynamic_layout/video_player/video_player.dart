import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../widgets/common/flux_image.dart';



class VideoPlayerLive extends StatefulWidget {
  final String url;
  final String placeHolder ;

  VideoPlayerLive({required this.url,required this.placeHolder});

  @override
  State<StatefulWidget> createState() {
    return _VideoState();
  }
}

class _VideoState extends State<VideoPlayerLive> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url);
      print("url : ${widget.url}");
    _chewieController = ChewieController(
      placeholder: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(20 ?? 0),
        ),
        child: AspectRatio(
          aspectRatio: 16/9,
          child: FluxImage(
            imageUrl: widget.placeHolder,
            fit: BoxFit.contain,
          ),
        ),
      ),
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16/9,
      autoPlay: false,
      looping: true,

      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );

  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 20),child: Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Chewie(
            controller: _chewieController!,
          ),
        ),
      ),
    ),);
  }
}

