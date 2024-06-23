import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../common/config.dart';
import '../../../../common/theme/colors.dart';
import '../../../../models/entities/blog.dart';
import '../../../../models/posts/article_detail_provider.dart';
import '../../../../models/posts/article_model.dart';
import '../../../../models/posts/search_article.dart';
import '../../../../services/services.dart';
import '../../../../widgets/blog/blog_action_button_mixin.dart';
import '../../../../widgets/blog/blog_card_view.dart';

class BlogList extends StatefulWidget {
  final name;
  final padding;
  final blogs;

  const BlogList({this.blogs, this.name, this.padding = 10.0});

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> with BlogActionButtonMixin {
  late RefreshController _refreshController;

  List<Article> _blogs = [];
  int _page = 1;

  @override
  // ignore: always_declare_return_types
  initState() {
    super.initState();
    _blogs = widget.blogs ?? [];
    _refreshController = RefreshController(initialRefresh: _blogs.isEmpty);
  }

  @override
  void didUpdateWidget(covariant BlogList oldWidget) {
    super.didUpdateWidget(oldWidget);
  }


  void _onRefresh() async {
    _page = 1;
    _blogs = [];

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _page = _page + 1;

    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final widthContent = (constraints.maxWidth - 48) / 2;

        return SmartRefresher(
          header: const MaterialClassicHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: _blogs.isEmpty
              ? const SizedBox()
              : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Wrap(
              spacing: 8,
              alignment: WrapAlignment.center,
              runSpacing: 8,
              children: <Widget>[
                for (var i = 0; i < _blogs.length; i++)
                  BlogCard(
                      item: _blogs[i],
                      width: widthContent,
                      onTap: () {

                      }
                    //onTapBlog(blog: _blogs[i], blogs: _blogs),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}


class BlogListSearch extends StatefulWidget {
  final name;
  final padding;
  final blogs;

  const BlogListSearch({this.blogs, this.name, this.padding = 10.0});

  @override
  _BlogListSearchState createState() => _BlogListSearchState();
}

class _BlogListSearchState extends State<BlogListSearch>
    with BlogActionButtonMixin {
  late RefreshController _refreshController;

  List<PostArticle> _blogs = [];
  int _page = 1;

  @override
  // ignore: always_declare_return_types
  initState() {
    super.initState();
    _blogs = widget.blogs ?? [];
    _blogs = _blogs.where((article) =>
    article.sanitizedTitle != null && article.sanitizedTitle!.isNotEmpty &&
        article.sanitizedExcerpt != null &&
        article.sanitizedExcerpt!.isNotEmpty &&
        article.mrssThumbnail != null && article.mrssThumbnail!.isNotEmpty
    ).toList();
    _refreshController = RefreshController(initialRefresh: _blogs.isEmpty);
  }


  void _onRefresh() async {
    _page = 1;
    _blogs = [];

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _page = _page + 1;

    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          final widthContent = (constraints.maxWidth - 48) / 2;

                return SmartRefresher(
                  header: const MaterialClassicHeader(),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: _blogs.isEmpty
                      ? const SizedBox()
                      : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(

                      children: <Widget>[
                        for (var i = 0; i < _blogs.length; i++)
                          BlogCardSearch(
                              item: _blogs[i],
                              width: widthContent,
                            onTap: ()=> onTapBlog(id:  _blogs[i].id.toString()),
                          )
                      ],
                    ),
                  ),
                );
              }



          );

  }

}