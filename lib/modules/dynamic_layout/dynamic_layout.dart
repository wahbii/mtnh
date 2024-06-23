import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/config.dart';
import '../../common/constants.dart';
import '../../common/tools.dart';
import '../../models/index.dart';
import '../../models/posts/article_model.dart';
import '../../models/posts/article_provider.dart';
import '../../routes/flux_navigate.dart';
import '../../services/index.dart';
import 'banner/banner_animate_items.dart';
import 'banner/banner_grid.dart';
import 'blog/blog_grid.dart';
import 'blog/blog_grid_web.dart';
import 'brand/brand_layout.dart';
import 'button/button.dart';
import 'category/category_icon.dart';
import 'category/category_menu_with_products.dart';
import 'category/category_text.dart';
import 'category/category_two_row.dart';
import 'config/banner_grid_config.dart';
import 'config/brand_config.dart';
import 'config/featured_vendor/featured_vendor_config.dart';
import 'config/index.dart';
import 'divider/divider.dart';
import 'header/header_search.dart';
import 'header/header_text.dart';
import 'helper/helper.dart';
import 'instagram_story/instagram_story.dart';
import 'logo/logo.dart';
import 'product/product_list_simple.dart';
import 'product/product_recent_placeholder.dart';
import 'slider_testimonial/index.dart';
import 'spacer/spacer.dart';
import 'story/index.dart';
import 'testimonial/index.dart';
import 'tiktok/index.dart';
import 'video/index.dart';
import 'video_player/video_player.dart';
import 'web_embed/web_embed_layout.dart';

class DynamicLayout extends StatelessWidget {
  final configLayout;
  final bool cleanCache;

  const DynamicLayout({this.configLayout, this.cleanCache = false});

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context, listen: true);
    final useDesktopStyle = Layout.isDisplayDesktop(context);
    context.read<ArticleNotifier>().loadArticles();
    final liveurl = context.read<ArticleNotifier>().getLiveUrl();

    var config = Map<String, dynamic>.from(configLayout);

    if (useDesktopStyle) {
      if (Layout.layoutSupportDesktop.contains(config['layout']) == false) {
        return const SizedBox();
      }

      config = Layout.changeLayoutForDesktopStyle(config);

      if (config.isEmpty) {
        return const SizedBox();
      }
    } else if (Layout.layoutOnlySupportDesktop.contains(config['layout']) ||
        'web' == config['useFor']) {
      return const SizedBox();
    }

    switch (config['layout']) {
      case Layout.logo:
        final themeConfig = appModel.themeConfig;
        return Logo(
          config: LogoConfig.fromJson(config),
          logo: themeConfig.logo,
          totalCart:
              Provider.of<CartModel>(context, listen: true).totalCartQuantity,
          notificationCount:
              Provider.of<NotificationModel>(context).unreadCount,
          onSearch: () {
            FluxNavigate.pushNamed(RouteList.homeSearch);
          },
          onCheckout: () {
            FluxNavigate.pushNamed(RouteList.cart);
          },
          onTapNotifications: () {
            FluxNavigate.pushNamed(RouteList.notify);
          },
          onTapDrawerMenu: () => NavigateTools.onTapOpenDrawerMenu(context),
        );

      case Layout.category:
        return Padding(
          padding: const EdgeInsets.only(
            left: 0.0,
            top: 0,
          ),
          child: Text(
            "Watch Mental Health TV Network Now",
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 20, fontFamily: "Roboto"),
          ),
        );

      case Layout.bannerImage:
        return Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: VideoPlayerLive(
              url: liveurl,
              placeHolder:
                  "https://static.mhtn.org/wp-content/uploads/2024/06/04141924/stream-poster.jpg",
            ));

      case Layout.saleOff:
        return Consumer<ArticleNotifier>(
            builder: (context, articleNotifier, child) {
          if (articleNotifier.isLoading) {
              return kLoadingWidget(context);
          }

          if (articleNotifier.errorMessage != null) {
            return Center(child: Text(articleNotifier.errorMessage!));
          }
          List<Article> data = List.from(articleNotifier.articles)
            ..sort((a, b) =>
                a.viewsCount7Days .compareTo(b.viewsCount7Days ));
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height * 0.42 ,
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.21,
                        width: MediaQuery.of(context).size.width,
                        // margin: EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text(
                                "Most Popular Posts ⚡️",
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.start,
                                style:
                                TextStyle(fontSize: 18, fontFamily: "Roboto"),
                              ),
                            ),
                            StoryWidget(
                              articles: data,
                            ),
                          ],
                        ))),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.21 ,
                    bottom: 0,
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.21,
                        width: MediaQuery.of(context).size.width,
                        // margin: EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text(
                                "Latest Posts ⚡️",
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.start,
                                style:
                                TextStyle(fontSize: 18, fontFamily: "Roboto"),
                              ),
                            ),
                            StoryWidget(
                              articles: articleNotifier.articles,
                            ),
                          ],
                        )))

              ],
            ),
          );
        });

      /// FluxNews
      case Layout.sliderList:
        return Consumer<ArticleNotifier>(
            builder: (context, articleNotifier, child) {
          if (articleNotifier.isLoading) {
            return Container();
          }

          if (articleNotifier.errorMessage != null) {
            return Center(child: Text(articleNotifier.errorMessage!));
          }

          return Services()
              .widget
              .renderSliderList(articleNotifier.getDataByCat());
        });

      default:
        return const SizedBox();
    }
  }
}
