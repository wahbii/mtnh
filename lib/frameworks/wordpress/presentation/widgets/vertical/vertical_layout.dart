import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../common/tools.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../models/posts/article_model.dart';
import '../../../../../models/posts/article_provider.dart';
import '../../../../../modules/dynamic_layout/config/blog_config.dart';
import '../../../../../screens/blog/index.dart';
import '../../../../../services/index.dart';
import '../../../../../widgets/blog/blog_action_button_mixin.dart';
import '../../../../../widgets/blog/blog_card_view.dart';
import 'vertical_simple_list.dart';

class VerticalViewLayout extends StatefulWidget {
  final BlogConfig config;

  const VerticalViewLayout({required this.config, super.key});

  @override
  State<VerticalViewLayout> createState() => _VerticalViewLayoutState();
}

class _VerticalViewLayoutState extends State<VerticalViewLayout>
    with BlogActionButtonMixin {
  final Services _service = Services();
  List<Article> _blogs = [];
  int _page = 0;
  bool canLoad = true;
  BlogCardType get type => widget.config.cardDesign;

  @override
  void initState() {
    super.initState();
    _blogs = context.read<ArticleNotifier>().articles ;
  }



  @override
  Widget build(BuildContext context) {
    var widthContent = 0.0;
    final screenSize = MediaQuery.of(context).size;
    final isTablet = Tools.isTablet(MediaQuery.of(context));
    final widthScreen = screenSize.width;
    if (widget.config.layout == 'card') {
      widthContent = widthScreen; //one column
    } else if (widget.config.layout == 'columns') {
      widthContent =
          isTablet ? widthScreen / 4 : (widthScreen / 3) - 15; //three columns
    } else {
      //layout is list
      widthContent =
          isTablet ? widthScreen / 3 : (widthScreen / 2) - 20; //two columns
    }

    return SliverPadding(
      padding: const EdgeInsets.only(left: 5.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          ...List.generate(_blogs.length, (i) {
            if (widget.config.layout == 'list') {
              return SimpleListView(
                item: _blogs[i],
                type: SimpleListType.backgroundColor,
              );
            }
            return BlogCard(
              item: _blogs[i],
              width: widthContent,
              config: widget.config,
              onTap: () {
                onTapBlog(article: _blogs[i], );
              },
            );
          }),

        ]),
      ),
    );
  }
}
