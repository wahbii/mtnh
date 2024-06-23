import 'package:flutter/material.dart';

import '../../../models/posts/article_model.dart';
import '../../../widgets/common/flux_image.dart';

class StoryCard extends StatefulWidget {
  final double? width;
  final Article? story;
  final double? ratioWidth;
  final double? ratioHeight;
  final BuildContext? buildContext;

  const StoryCard({
    super.key,
    this.story,
    this.width,
    this.ratioWidth,
    this.ratioHeight,
    this.buildContext,
  });

  @override
  State<StoryCard> createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard> {
  double? _width;
  double _opacity = 1;

  @override
  void initState() {
    WidgetsBinding.instance.endOfFrame.then((_) {
      if (mounted) {
        setState(() {
          _opacity = 1;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        _width = widget.width ?? constraint.maxWidth;
        final ratioWidth = widget.ratioWidth ?? 1.0;
        final ratioHeight = widget.ratioHeight ?? 1.0;
        final story = widget.story;
        return SizedBox(
          width: 16,
          height: 9,
          child: Stack(
            //fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: FluxImage(
                    imageUrl: story?.mrssThumbnail ?? "",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
