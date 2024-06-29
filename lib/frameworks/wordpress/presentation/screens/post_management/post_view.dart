import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

import '../../../../../common/tools/image_tools.dart';
import '../../../../../models/posts/article_model.dart';
import '../../../../../screens/blog/index.dart';
import '../../../../../widgets/blog/blog_action_button_mixin.dart';

class PostView extends StatelessWidget with BlogActionButtonMixin {
  final List<Article>? blogs;
  final int? index;
  final double? width;
  final String? type;
  final double? imageBorder;
  final String? locale;

  const PostView({
    this.blogs,
    this.index,
    this.width,
    this.type,
    this.imageBorder = 4,
    this.locale = 'en',
  });

  @override
  Widget build(BuildContext context) {
    var imageWidth = (width == null) ? 150.0 : width;
    var titleFontSize = imageWidth! / 10;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      child: GestureDetector(
        onTap: () => onTapBlog(article: blogs?[index ?? 0], ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(imageBorder!),
                ),
                child: ImageResize(
                  url: blogs![index!].mrssThumbnail,
                  width: imageWidth,
                  height: imageWidth,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      blogs![index!].sanitizedTitle?? "",
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: imageWidth / 35,
                    ),
                    Text(
                      blogs![index!].date == null ? "" : DateFormat('d MMMM yyyy').format(blogs![index!].date!),

                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    blogs![index!].sanitizedExcerpt == 'Loading...'
                        ? Text(blogs![index!].sanitizedExcerpt ?? "")
                        : Text(
                            parse(blogs![index!].sanitizedExcerpt).documentElement!.text,
                            maxLines: 3,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 13.0,
                                    height: 1.4,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
