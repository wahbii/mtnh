import 'dart:async';

import 'package:flutter/material.dart';

import '../../common/config.dart';
import '../../common/constants.dart';
import '../../common/tools.dart';
import '../../screens/base_screen.dart';
import 'animated_splash.dart';
import 'flare_splash_screen.dart';
import 'lottie_splashscreen.dart';
import 'rive_splashscreen.dart';
import 'static_splashscreen.dart';

class SplashScreenIndex extends StatelessWidget {
  final Function actionDone;
  final String splashScreenType;
  final String imageUrl;
  final int duration;

  /// The manager and delivery apps do not load appConfig, so it cannot listen to the event `EventLoadedAppConfig` to navigate to the next screen
  final bool isLoadAppConfig;

  const SplashScreenIndex({
    super.key,
    required this.actionDone,
    required this.imageUrl,
    this.splashScreenType = SplashScreenTypeConstants.static,
    this.duration = 2000,
    this.isLoadAppConfig = true,
  });

  @override
  Widget build(BuildContext context) {

      final boxFit = ImageTools.boxFit(
        kSplashScreen.boxFit,
        defaultValue: BoxFit.contain,
      );
      final backgroundColor = HexColor(kSplashScreen.backgroundColor);
      final paddingTop = kSplashScreen.paddingTop;
      final paddingBottom = kSplashScreen.paddingBottom;
      final paddingLeft = kSplashScreen.paddingLeft;
      final paddingRight = kSplashScreen.paddingRight;

          return StaticSplashScreen(
            imagePath: "assets/images/MHTNLOGOFINAL.svg",
            onNextScreen: actionDone,
            duration: duration,
            backgroundColor: backgroundColor,
            boxFit: boxFit,
            paddingTop: paddingTop,
            paddingBottom: paddingBottom,
            paddingLeft: paddingLeft,
            paddingRight: paddingRight,
          );



  }

}

class _EmptySplashScreen extends StatefulWidget {
  final Function? onNextScreen;
  final bool? isLoadAppConfig;

  const _EmptySplashScreen({
    this.onNextScreen,
    this.isLoadAppConfig,
  });

  @override
  _EmptySplashScreenState createState() => _EmptySplashScreenState();
}

class _EmptySplashScreenState extends BaseScreen<_EmptySplashScreen> {
  StreamSubscription? _subscription;

  @override
  void initState() {
    if (widget.isLoadAppConfig == true) {
      _subscription = eventBus.on<EventLoadedAppConfig>().listen(listener);
    } else {
      WidgetsBinding.instance.endOfFrame.then(listener);
    }
    super.initState();
  }

  void listener(_) {
    if (mounted) {
      widget.onNextScreen?.call();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: kLoadingWidget(context),
    );
  }
}
