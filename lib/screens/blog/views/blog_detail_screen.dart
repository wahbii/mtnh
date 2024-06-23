import 'package:flutter/material.dart';
import 'package:inspireui/inspireui.dart';
import 'package:provider/provider.dart';

import '../../../common/config.dart';
import '../../../common/constants.dart';
import '../../../models/app_model.dart';
import '../../../models/entities/blog.dart';
import '../../../models/posts/article_detail_provider.dart';
import '../../../models/posts/article_model.dart';
import '../../../modules/dynamic_layout/helper/helper.dart';
import '../../../services/services.dart';
import '../../../widgets/blog/detailed_blog_fullsize_image.dart';
import '../../../widgets/blog/detailed_blog_half_image.dart';
import '../../../widgets/blog/detailed_blog_quarter_image.dart';
import '../../../widgets/blog/detailed_blog_view.dart';
import '../../base_screen.dart';
import '../../common/app_bar_mixin.dart';
import '../models/list_blog_model.dart';
import 'blog_detail_screen_web.dart';

class BlogDetailArguments {
  final Article? blog;
  final String? id;

  BlogDetailArguments({
    this.blog,
    this.id,
  });
}

class BlogDetailScreen extends StatefulWidget {
  final Article? blog;
  final String? id;

  const BlogDetailScreen({
    required this.blog,
    this.id,
  });

  @override
  BaseScreen<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends BaseScreen<BlogDetailScreen>
    with AppBarMixin {
  PageController controller = PageController(initialPage: 0);
  Article? blog = null;

  var initialPage = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    blog = widget.blog ?? blog;
    if(blog==null){
      context.read<ArticleDetailNotifier>().loadArticles(widget.id.toString());
    }
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) async {


      blog = widget.blog;
      setState(() {});


    /// This case handle for the Notion platform
    /// The blog item from List Blog get from Notion does not contain the content
    /// So need get content of the blog in the BlogDetail

  }

  @override
  Widget build(BuildContext context) {
    if(widget.blog == null){

      return  Consumer<ArticleDetailNotifier>(
        builder: (context, articleNotifier, child) {
          if (articleNotifier.isLoading) {
            return kLoadingWidget(context);
          }



          if (articleNotifier.errorMessage != null) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                  child: Text(articleNotifier.errorMessage.toString(),
                      style: const TextStyle(color: kErrorRed))),
            );
          }

          return
            AutoHideKeyboard(
              child: renderScaffold(
                routeName: RouteList.detailBlog,
                child: Builder(
                  builder: (context) {
                    return _buildDetailScreen(articleNotifier.article!);



                  },
                ),
              ),
            );



        },
      )  ;
    }else {
      return AutoHideKeyboard(
        child: renderScaffold(
          routeName: RouteList.detailBlog,
          child: Builder(
            builder: (context) {
              return _buildDetailScreen(blog!);



            },
          ),
        ),
      );
    }
  }

  Widget _buildDetailScreen(Article blog) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        padding: showAppBar(RouteList.detailBlog) ? EdgeInsets.zero : null,
      ),
      child: Builder(
        builder: (context) {
          return OneQuarterImageType(item: blog);
        }




      ),
    );
  }
}
