import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../modules/dynamic_layout/helper/header_view.dart' as header;
import '../../common/config.dart';
import '../../common/constants.dart';
import '../../common/tools.dart';
import '../../models/index.dart';
import '../../models/posts/article_model.dart';
import '../../models/posts/article_provider.dart';
import '../../routes/flux_navigate.dart';
import '../../services/index.dart';
import 'config/index.dart';
import 'helper/helper.dart';
import 'logo/logo.dart';
import 'story/index.dart';
import 'video_player/video_player.dart';

class DynamicLayout extends StatelessWidget {
  final configLayout;
  final bool cleanCache;

  const DynamicLayout({this.configLayout, this.cleanCache = false});

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context, listen: true);
    final useDesktopStyle = Layout.isDisplayDesktop(context);
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
    return Consumer<ArticleNotifier>(
        builder: (context, articleNotifier, child) {
      if (articleNotifier.isLoading) {
        return kLoadingWidget(context);
      }

      if (articleNotifier.errorMessage != null) {
        return Center(child: Text(articleNotifier.errorMessage!));
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
          List<Article> data = List.from(articleNotifier.articles)
            ..sort((a, b) => a.viewsCount7Days.compareTo(b.viewsCount7Days));
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.44,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.22,
                      width: MediaQuery.of(context).size.width,
                      // margin: EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          header.HeaderView(
                            headerText: "Most Popular Posts ⚡️",
                            showSeeAll: false,
                          ),
                          StoryWidget(
                            articles: data,
                          ),
                        ],
                      )),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.22,
                        width: MediaQuery.of(context).size.width,
                        // margin: EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            header.HeaderView(
                              headerText: "Latest Posts ⚡️",
                              showSeeAll: false,
                            ),
                            StoryWidget(
                              articles: articleNotifier.articles,
                            ),
                          ],
                        )))
              ],
            ),
          );

        /// FluxNews
        case Layout.sliderList:
          return Services()
              .widget
              .renderSliderList(articleNotifier.getDataByCat());

        default:
          return const SizedBox();
      }
    });
  }
}
