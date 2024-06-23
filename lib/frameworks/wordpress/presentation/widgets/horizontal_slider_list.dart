import 'package:flutter/material.dart';
import 'package:inspireui/inspireui.dart';
import 'package:intl/intl.dart' as it;

import '../../../../common/constants.dart';
import '../../../../models/index.dart';
import '../../../../models/posts/article_model.dart';
import '../../../../modules/dynamic_layout/helper/header_view.dart';
import '../../../../routes/flux_navigate.dart';
import '../../../../widgets/blog/blog_action_button_mixin.dart';
import '../../../../widgets/common/background_color_widget.dart';
import '../../../../widgets/common/index.dart' show FluxImage;

class HorizontalSliderList extends StatefulWidget {
  final List<MapEntry<String, List<Article>>>? config;

  const HorizontalSliderList({required this.config, super.key});

  @override
  State<HorizontalSliderList> createState() => _HorizontalSliderListState();
}

class _HorizontalSliderListState extends State<HorizontalSliderList>
    with BlogActionButtonMixin {
  final _listBlogNotifier =
      ValueNotifier<List<MapEntry<String, List<Article>>>?>(null);
  final _pageController = PageController();

  List<MapEntry<String, List<Article>>>? get configJson => widget.config;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then((_) async {
      if (mounted) {
        _listBlogNotifier.value = configJson;
      }
    });
  }

  @override
  void dispose() {
    _listBlogNotifier.dispose();
    _pageController.dispose();
    super.dispose();
  }

  final blogEmptyList = const [Blog.empty(1), Blog.empty(2), Blog.empty(3)];

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final isRecent = false;
    final enableBackground = true;



    return BackgroundColorWidget(
      enable: enableBackground,
      child: ValueListenableBuilder<List<MapEntry<String, List<Article>>>?>(
        valueListenable: _listBlogNotifier,
        builder: (context, value, child) {
          var body = Column(
            children: value!.map((section) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderView(
                    headerText: section.key,
                    showSeeAll: isRecent ? false : true,
                    verticalMargin: 4,
                    callback: () => FluxNavigate.pushNamed(
                      RouteList.backdrop,
                      arguments: BackDropArguments(
                        data: section.value,
                        title: section.key
                      ),
                    ),
                  ),
                  Column(
                    children: section.value.take(3).map((article) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: _BlogItem(
                            blog: article,
                            type: "imageOnTheRight",
                            imageBorder: 12.0,
                            onTap: () => onTapBlog(article: article, ),

                          ));
                    }).toList(),
                  ),
                ],
              );
            }).toList(),
          );
          return body;
        },
      ),
    );
  }
}

class _BlogItem extends StatelessWidget {
  final Article blog;
  final String? type;
  final double? imageBorder;
  final onTap;

  const _BlogItem({
    required this.blog,
    this.type,
    this.imageBorder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const direction = TextDirection.ltr;
    return Container(
      height: MediaQuery.of(context).size.height * 0.14,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: direction,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(imageBorder ?? 0),
                ),
                child: AspectRatio(
                  aspectRatio: 16/9,
                  child: FluxImage(
                    imageUrl: blog.mrssThumbnail,
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
                    blog.sanitizedTitle,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(

                       it.DateFormat('d MMMM yyyy').format(blog.date)
                    ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    blog.sanitizedExcerpt
                        .replaceAll("<p>", "")
                        .replaceAll("</p>", ""),
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

class _SliderListItemSkeleton extends StatelessWidget {
  const _SliderListItemSkeleton({this.textDirection = TextDirection.ltr});

  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 12,
        right: textDirection == TextDirection.ltr ? 0 : 12,
        bottom: 16,
        top: 12,
      ),
      child: SizedBox(
        height: 150,
        width: 400,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          textDirection: textDirection,
          children: [
            const Flexible(
              flex: 5,
              child: Skeleton(),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Skeleton(
                    width: 200,
                    height: 14,
                  ),
                  const SizedBox(height: 4),
                  const Skeleton(
                    width: 120,
                    height: 14,
                  ),
                  const SizedBox(height: 12),
                  const Skeleton(
                    width: 80,
                    height: 12,
                  ),
                  const SizedBox(height: 24),
                  ...List.filled(
                    3,
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4.0),
                      child: Skeleton(
                        width: 200,
                        height: 12,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
