import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mtnh/screens/onboarding/onboardingscreen.dart';

class SplashScreen extends StatefulWidget {
  static String path = "/";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      setState(() {
        _seconds++;
        if (_seconds == 5) {
          timer.cancel();
          // Navigate to another widget after 10 seconds
          Navigator.pushReplacementNamed(context, OnBoardingScreen.path);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      color: Color.fromARGB(255, 255, 255, 255),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset(
              width: MediaQuery.sizeOf(context).width * 0.6,
              height: MediaQuery.sizeOf(context).width * 0.4,
              fit: BoxFit.fill,
              "assets/images/ic_app_icon.png"),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.7,
            height: 5,
            child: const LinearProgressIndicator(
              backgroundColor: Colors.lightBlue,
              valueColor: AlwaysStoppedAnimation(Colors.lightGreen),
              minHeight: 5,
            ),
          )
        ],
      ),
    );
  }
}
