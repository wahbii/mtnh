import 'package:flutter/material.dart';
import 'package:inspireui/icons/constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/constants.dart';
import '../../common/extensions/buildcontext_ext.dart';
import '../../common/tools.dart';
import '../../generated/l10n.dart';
import '../../models/index.dart' show CartModel, ProductWishListModel;
import '../../models/posts/article_fav.dart';
import '../../models/posts/article_model.dart';
import '../../modules/dynamic_layout/config/product_config.dart';
import '../../modules/dynamic_layout/helper/helper.dart';
import '../../services/services.dart';
import '../../widgets/web_layout/web_layout.dart';
import '../../widgets/web_layout/widgets/path_header_widget.dart';
import '../common/app_bar_mixin.dart';
import 'empty_wishlist.dart';
import 'empty_wishlist_web.dart';
import 'wishlist_item_widget.dart';

class ProductWishListScreen extends StatefulWidget {
  const ProductWishListScreen();

  @override
  State<StatefulWidget> createState() => _WishListState();
}

class _WishListState extends State<ProductWishListScreen> with AppBarMixin {
  final ScrollController _scrollController = ScrollController();
  List<Article> _articles = [];


  @override
  void initState() {
    super.initState();
    screenScrollController = _scrollController;
    _loadArticles();
  }
  Future<void> _loadArticles() async {
    final List<Article> articles = await SharedPreferencesHelper.getArticles();
    print("hello ${articles.length}" );
    setState(() {
      _articles = articles;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Layout.isDisplayDesktop(context);
    print("hello ${_articles.length}" );

    return renderScaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      routeName: RouteList.wishlist,
      secondAppBar: AppBar(
              iconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.secondary,
              ),
              elevation: 0.5,
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: Text(
                S.of(context).myWishList,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
      child: _articles.isEmpty ? EmptyWishlist(
        onShowHome: () => NavigateTools.navigateToDefaultTab(context),
        onSearchForItem: () => NavigateTools.navigateToRootTab(
          context,
          RouteList.search,
        ),
      ) : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            child: Text(
              '${_articles.length} ${S.of(context).items}',
              style: const TextStyle(
                fontSize: 14,
                color: kGrey400,
              ),
            ),
          ),
          const Divider(height: 1, color: kGrey200),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _articles.length,
              itemBuilder: (context, index) {
                return WishlistItem(
                  product: _articles[index],
                  onRemove: () async {
                  await  SharedPreferencesHelper.removeArticle(_articles[index]);
                  Tools.showSnackBar(
                      ScaffoldMessenger.of(context), "item is removed from your fav");
                  _loadArticles();
                  },
                  onAddToCart: () async {
                await  SharedPreferencesHelper.addArticle(_articles[index]);
                Tools.showSnackBar(
                ScaffoldMessenger.of(context), "item is removed from your fav");
                _loadArticles();
                },
                );
              },
            ),
          )
        ],
      )); }




}
