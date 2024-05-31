import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum _MenuOptions {
  navigationDelegate,
  userAgent,
  javascriptChannel,
  listCookies,
  clearCookies,
  addCookie,
  setCookie,
  removeCookie,
}

class HomeScreen extends StatefulWidget {
  static String path = "/home";

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeScreen> {
  late final WebViewController controller;
  var loadingPercentage = 0;
  var listPath = ["", "#watch-live", "?s=", "help/"];
  final _pageController = PageController(initialPage: 0);

  var baseUrl = "https://mhtn.org/";

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 5;

  /// widget list
  late List<Widget> bottomBarPages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {
            print("error :${error.description} : ${error.url}");
          },
        ),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://mhtn.org/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: Colors.lightBlue,
        showLabel: true,
        itemLabelStyle: const TextStyle(color: Colors.white, fontSize: 10.0),
        shadowElevation: 5,
        kBottomRadius: 28.0,
        // notchShader: const SweepGradient(
        //   startAngle: 0,
        //   endAngle: pi / 2,
        //   colors: [Colors.red, Colors.green, Colors.orange],
        //   tileMode: TileMode.mirror,
        // ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8.0)),
        notchColor: Colors.lightGreen,

        removeMargins: false,
        bottomBarWidth: 500,
        showShadow: false,
        durationInMilliSeconds: 300,
        elevation: 1,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            activeItem: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            itemLabel: "Home",
          ),
          BottomBarItem(
            inActiveItem: const Icon(
              Icons.live_tv,
              color: Colors.white,
            ),
            activeItem: const Icon(
              Icons.live_tv,
              color: Colors.white,
            ),
            itemLabel: "Live",
          ),
          BottomBarItem(
            inActiveItem: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            activeItem: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            itemLabel: "Health",
          ),
          BottomBarItem(
            inActiveItem: const Icon(
              Icons.help,
              color: Colors.white,
            ),
            activeItem: const Icon(
              Icons.help,
              color: Colors.white,
            ),
            itemLabel: "Help",
          ),
        ],
        onTap: (index) {
          /// perform action on tab change and to update pages you can update pages without pages
          //_pageController.jumpToPage(index);
          controller.loadRequest(Uri.parse("${baseUrl}${listPath[index]}"));
        },
        kIconSize: 24.0,
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
              backgroundColor: Colors.lightBlue,
              valueColor: AlwaysStoppedAnimation(Colors.lightGreen),
            ),
        ],
      ),
    );
  }
}
