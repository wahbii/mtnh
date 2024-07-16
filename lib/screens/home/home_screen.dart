import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // Import this for SchedulerBinding
import 'package:inspireui/widgets/smart_engagement_banner/index.dart';
import 'package:provider/provider.dart';

import '../../app.dart';
import '../../common/config.dart';
import '../../common/constants.dart';
import '../../data/boxes.dart';
import '../../models/app_model.dart';
import '../../models/posts/article_provider.dart';
import '../../modules/dynamic_layout/index.dart';
import '../../modules/dynamic_layout/video_player/video_player.dart';
import '../../widgets/home/index.dart';
import '../base_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({this.scrollController});

  final ScrollController? scrollController;

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends BaseScreen<HomeScreen> {
  // @override
  // bool get wantKeepAlive => true;

  ValueNotifier<bool> isVisible = ValueNotifier<bool>(false); // Example initialization

  @override
  void dispose() {
    printLog('[Home] dispose');
    super.dispose();
  }

  @override
  void initState() {
    printLog('[Home] initState');
    widget.scrollController?.addListener(_scrollListener);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Assuming ArticleNotifier is a ChangeNotifier
      final articleNotifier =
          Provider.of<ArticleNotifier>(context, listen: false);
      articleNotifier.loadArticles();
    });
    super.initState();
  }

  void afterClosePopup(int updatedTime) {
    SettingsBox().popupBannerLastUpdatedTime = updatedTime;
  }

  @override
  Widget build(BuildContext context) {
    printLog('[Home] build');
    final liveurl = context.read<ArticleNotifier>().getLiveUrl();

    return Selector<AppModel, (AppConfig?, String, String?)>(
      selector: (_, model) =>
          (model.appConfig, model.langCode, model.countryCode),
      builder: (_, value, child) {
        var appConfig = value.$1;
        var langCode = value.$2;
        final countryCode = value.$3;

        if (appConfig == null) {
          return kLoadingWidget(context);
        }

        var isStickyHeader = appConfig.settings.stickyHeader;
        final horizontalLayoutList =
            List.from(appConfig.jsonData['HorizonLayout']);
        final isShowAppbar = horizontalLayoutList.isNotEmpty &&
            horizontalLayoutList.first['layout'] == 'logo';

        final bannerConfig = appConfig.settings.smartEngagementBannerConfig;

        final isShowPopupBanner = (SettingsBox().popupBannerLastUpdatedTime !=
                bannerConfig.popup.updatedTime) ||
            bannerConfig.popup.alwaysShowUponOpen;

        return FloatingDraggableWidget(
            floatingWidget:ValueListenableBuilder<bool>(
              builder: (BuildContext context, bool value, Widget? child) {
                return value
                    ? VideoPlayerLive(
                  url: liveurl,
                  placeHolder: "https://static.mhtn.org/wp-content/uploads/2024/06/04141924/stream-poster.jpg",
                )
                    : Container();
              },
              valueListenable: isVisible,
            )
            ,
            floatingWidgetWidth: MediaQuery.of(context).size.width * 0.6,
            floatingWidgetHeight: MediaQuery.of(context).size.height * 0.18,
            mainScreenWidget: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              body: Stack(
                children: <Widget>[
                  if (appConfig.background != null && isDesktop == false)
                    isStickyHeader
                        ? SafeArea(
                            child: HomeBackground(config: appConfig.background),
                          )
                        : HomeBackground(config: appConfig.background),
                  HomeLayout(
                    isPinAppBar: isStickyHeader,
                    isShowAppbar: isShowAppbar,
                    showNewAppBar:
                        appConfig.appBar?.shouldShowOn(RouteList.home) ?? false,
                    configs: appConfig.jsonData,
                    key: Key('$langCode$countryCode'),
                    scrollController: widget.scrollController,
                  ),

                  SmartEngagementBanner(
                    context: App.fluxStoreNavigatorKey.currentContext!,
                    config: bannerConfig,
                    enablePopup: isShowPopupBanner,
                    afterClosePopup: () {
                      afterClosePopup(bannerConfig.popup.updatedTime);
                    },
                    childWidget: (data) {
                      return DynamicLayout(configLayout: data);
                    },
                  ),
                  // Remove `WrapStatusBar` because we already have `SafeArea`
                  // inside `HomeLayout`
                  // const WrapStatusBar(),
                ],
              ),
            ));
      },
    );
  }

  void _scrollListener() {
    var height = widget.scrollController?.position.pixels ?? 0;
    print("height : $height");
    if (height > 250) {
      if (!isVisible.value) {
          isVisible.value = true;
      }
    } else {
      if (isVisible.value) {
          isVisible.value = false;
      }
    }
  }
}
