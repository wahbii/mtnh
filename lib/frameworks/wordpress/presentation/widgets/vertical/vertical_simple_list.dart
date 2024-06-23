import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../common/tools.dart';
import '../../../../../models/posts/article_model.dart';
import '../../../../../screens/blog/index.dart';
import '../../../../../widgets/blog/blog_action_button_mixin.dart';

enum SimpleListType { backgroundColor, priceOnTheRight }

class SimpleListView extends StatelessWidget with BlogActionButtonMixin {
  final Article item;
  final SimpleListType type;

  const SimpleListView({
    required this.item,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var titleFontSize = 15.0;
    var imageWidth = 60;
    var imageHeight = 60;
    void onTapProduct() {
      onTapBlog(article: item,);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: GestureDetector(
        onTap: onTapProduct,
        child: Container(
          width: screenWidth,
          decoration: BoxDecoration(
            color: type == SimpleListType.backgroundColor
                ? Theme.of(context).primaryColorLight
                : null,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      child: ImageResize(
                        url: item.mrssThumbnail,
                        width: imageWidth.toDouble(),
                        size: kSize.medium,
                        height: imageHeight.toDouble(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        item.sanitizedTitle,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        DateFormat('d MMMM yyyy').format( item.date),

                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.5),
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
