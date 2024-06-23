import '../../common/constants.dart';
import '../../models/entities/blog.dart';
import '../../models/posts/article_model.dart';
import '../../modules/analytics/analytics.dart';
import '../../routes/flux_navigate.dart';
import '../../screens/blog/views/blog_detail_screen.dart';

mixin BlogActionButtonMixin {
  void onTapBlog({
    String? id,
    Article? article,
    bool forceRootNavigator = false,
  }) {
    FluxNavigate.pushNamed(
      RouteList.detailBlog,
      arguments: BlogDetailArguments(
        id: id,
        blog: article,
      ),
      forceRootNavigator: forceRootNavigator,
    );
  }
}
