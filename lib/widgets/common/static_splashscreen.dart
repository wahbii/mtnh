import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../models/posts/article_provider.dart';
import '../../screens/base_screen.dart';
import 'flux_image.dart';

class StaticSplashScreen extends StatefulWidget {
  final String? imagePath;
  final Function? onNextScreen;
  final int duration;
  final Color backgroundColor;
  final BoxFit boxFit;
  final double paddingTop;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;

  const StaticSplashScreen({
    super.key,
    this.imagePath,
    this.onNextScreen,
    this.duration = 2500,
    this.backgroundColor = Colors.white,
    this.boxFit = BoxFit.contain,
    this.paddingTop = 0.0,
    this.paddingBottom = 0.0,
    this.paddingLeft = 0.0,
    this.paddingRight = 0.0,
  });

  @override
  BaseScreen<StaticSplashScreen> createState() => _StaticSplashScreenState();
}


class _StaticSplashScreenState extends BaseScreen<StaticSplashScreen> {

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Assuming ArticleNotifier is a ChangeNotifier
      final articleNotifier = Provider.of<ArticleNotifier>(context, listen: false);
      articleNotifier.loadArticles();
    });
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(Duration(milliseconds: widget.duration), () {
      widget.onNextScreen?.call();
//      Navigator.of(context).pushReplacement(
//          MaterialPageRoute(builder: (context) => widget.onNextScreen));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          top: widget.paddingTop,
          bottom: widget.paddingBottom,
          left: widget.paddingLeft,
          right: widget.paddingRight,
        ),
        child:  LayoutBuilder(
          builder: (context, constraints) {
            return      Image.asset(
                width: MediaQuery.sizeOf(context).width * 0.6,
                height: MediaQuery.sizeOf(context).width * 0.4,
                fit: BoxFit.fill,
                "assets/images/ic_app_icon.png");
          },
        ),
      ),
    );
  }
}
