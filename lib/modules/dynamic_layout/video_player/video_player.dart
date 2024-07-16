import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:video_player/video_player.dart';

import '../../../widgets/common/flux_image.dart';
import 'package:cast/cast.dart';

import 'bottomsheet_dialog.dart';

class VideoPlayerLive extends StatefulWidget {
  final String url;
  final String placeHolder;

  VideoPlayerLive({required this.url, required this.placeHolder});

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
    _chewieController = ChewieController(
      placeholder: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(20 ?? 0),
        ),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: FluxImage(
            imageUrl: widget.placeHolder,
            fit: BoxFit.contain,
          ),
        ),
      ),
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Chewie(
                  controller: _chewieController!,
                ),
              ),
            ),
          ),
          Positioned(
              top: MediaQuery.sizeOf(context).height * 0.038,
              right: MediaQuery.sizeOf(context).width*0.1,
              child: InkWell(
                onTap: () {
                  CastDeviceBottomSheet.show(context);
                },
                child: Icon(Icons.cast,color: Colors.white,),
              ))
        ],
      ),
    );
  }


}
