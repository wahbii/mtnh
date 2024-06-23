import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/tools.dart';
import '../../models/posts/article_model.dart';
import '../../models/posts/search_article.dart';
import '../../modules/dynamic_layout/index.dart';
import '../common/flux_image.dart';
import '../html/index.dart';

class BlogCard extends StatelessWidget {
  final Article? item;
  final width;
  final margin;
  final kSize size;
  final height;
  final VoidCallback onTap;
  final BlogConfig? config;

  const BlogCard({
    this.item,
    this.width,
    this.size = kSize.medium,
    this.height,
    this.margin = 5.0,
    required this.onTap,
    this.config,
  });

  Widget getImageFeature(double imageWidth, {double? imageHeight}) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: ImageResize(
          url: item!.mrssThumbnail,
          width: imageWidth,
          height: height ?? imageHeight ?? width * 0.60,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget renderAuthor() {
    return Row(
      children: [
        const Icon(Icons.drive_file_rename_outline_outlined,
            color: Colors.white, size: 12),
        const SizedBox(width: 2),
        Text(
          item!.sanitizedTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = Tools.isTablet(MediaQuery.of(context));
    final blogConfig = config ?? BlogConfig.empty();
    var titleFontSize = isTablet ? 20.0 : 14.0;
    var maxWidth = width;
    if (blogConfig.cardDesign == BlogCardType.background) {
      titleFontSize = titleFontSize * maxWidth / 150;
      var isSmallSize = titleFontSize < 14.0;
      if (isSmallSize) titleFontSize = 14.0;

      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: blogConfig.hMargin,
          vertical: blogConfig.vMargin,
        ),
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              getImageFeature(maxWidth, imageHeight: maxWidth),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: maxWidth,
                height: maxWidth,
              ),
              Container(
                width: maxWidth,
                height: maxWidth,
                padding: EdgeInsets.symmetric(
                    horizontal: isSmallSize ? 5.0 : 10.0,
                    vertical: isSmallSize ? 5.0 : 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      item!.sanitizedTitle,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                              ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    if (!isSmallSize) ...[
                      SizedBox(
                        height: 50,
                        child: HtmlWidget(
                          item!.sanitizedExcerpt,
                          textStyle: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            DateFormat('d MMMM yyyy').format(item!.date),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        if (!isSmallSize) renderAuthor(),
                      ],
                    ),
                    if (isSmallSize) renderAuthor(),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: blogConfig.hMargin,
        vertical: blogConfig.vMargin,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          getImageFeature(maxWidth),
          Container(
            width: maxWidth,
            padding:
                const EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item!.sanitizedTitle,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  DateFormat('d MMMM yyyy').format(item!.date),
                  style: TextStyle(
                    color: theme.colorScheme.secondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BlogCardSearch extends StatelessWidget {
  final PostArticle? item;
  final width;
  final margin;
  final kSize size;
  final height;
  final VoidCallback onTap;
  final BlogConfig? config;

  const BlogCardSearch({
    this.item,
    this.width,
    this.size = kSize.medium,
    this.height,
    this.margin = 5.0,
    required this.onTap,
    this.config,
  });

  Widget renderAuthor() {
    return Row(
      children: [
        const Icon(Icons.drive_file_rename_outline_outlined,
            color: Colors.white, size: 12),
        const SizedBox(width: 2),
        Text(
          item?.title ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget getImageFeature(double imageWidth, {double? imageHeight}) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: ImageResize(
          url: item?.mrssThumbnail ?? "",
          width: imageWidth,
          height: height ?? imageHeight ?? width * 0.60,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = Tools.isTablet(MediaQuery.of(context));
    final blogConfig = config ?? BlogConfig.empty();
    var titleFontSize = isTablet ? 20.0 : 14.0;
    var maxWidth = width;
    if (blogConfig.cardDesign == BlogCardType.background) {
      titleFontSize = titleFontSize * maxWidth / 150;
      var isSmallSize = titleFontSize < 14.0;
      if (isSmallSize) titleFontSize = 14.0;

      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: blogConfig.hMargin,
          vertical: blogConfig.vMargin,
        ),
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              getImageFeature(maxWidth, imageHeight: maxWidth),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: maxWidth,
                height: maxWidth,
              ),
              Container(
                width: maxWidth,
                height: maxWidth,
                padding: EdgeInsets.symmetric(
                    horizontal: isSmallSize ? 5.0 : 10.0,
                    vertical: isSmallSize ? 5.0 : 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      item!.sanitizedTitle ?? "",
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                              ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    if (!isSmallSize) ...[
                      SizedBox(
                        height: 50,
                        child: HtmlWidget(
                          item!.sanitizedExcerpt ?? "",
                          textStyle: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                    if (isSmallSize) renderAuthor(),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
    final direction = TextDirection.LTR;
    // Non-nullable TextDirection
    return Container(
      height: MediaQuery.of(context).size.height * 0.14,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(29),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: FluxImage(
                    imageUrl: item?.mrssThumbnail ?? "",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item?.sanitizedTitle ?? "",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: item!.categoryTitles!
                        .map((elm) => Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.symmetric(horizontal: 1),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey),
                              child: Text(
                                "#${elm}",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color:
                                        Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                        .toList(),
                  ),
                  Text(
                    item!.sanitizedExcerpt ?? "",
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 10.0,
                        height: 1.4,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
//                              : HtmlWidget(
//                                  blogs[index].excerpt.substring(0, 100) + ' ...',
//                                  bodyPadding: EdgeInsets.only(top: 15),
//                                  hyperlinkColor: Theme.of(context).primaryColor.withOpacity(0.9),
//                                  textStyle: Theme.of(context).textTheme.body1.copyWith(
//                                      fontSize: 13.0,
//                                      height: 1.4,
//                                      color: Theme.of(context).colorScheme.secondary),
//                                ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
