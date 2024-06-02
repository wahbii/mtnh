import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:mtnh/screens/home/homescreenn.dart';
import 'package:mtnh/screens/onboarding/views/policy_modal.dart';

class OnBoardingScreen extends StatefulWidget {
  static String path = "/onboarding";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OnboardingScreenState();
  }
}

class OnboardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: OnBoardingSlider(
        onFinish: () {

            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => RulesModalDialog(
                showBtn: true,
                filname: "assets/pdf/disclamer.pdf",
              ),
            );

        },
        finishButtonTextStyle: TextStyle(fontSize: 16, color: Colors.white),
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Start Exploring',
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: Color(0xff6BCB89),
        ),
        skipTextButton: InkWell(
          onTap: (){
            Navigator.pushReplacementNamed(context, HomeScreen.path);
          },
            child: Text('Skip',
                style: TextStyle(fontSize: 16, color: Color(0xff6BCB89)))),
        background: [
          //Image.asset('assets/slide_2.png'),
          Container(
            color: Colors.white,
          ),
          Container()
        ],
        totalPage: 2,
        speed: 1.0,
        pageBodies: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.7,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  width: MediaQuery.sizeOf(context).width,
                  child: Image.asset('assets/images/onboarding1.png'),
                ),
                Text(
                  "MHTN is a revolutionary streaming network committed to transforming the conversation around mental health.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.sizeOf(context).height * 0.7,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  width: MediaQuery.sizeOf(context).width,
                  child: Image.asset('assets/images/onboarding2.png'),
                ),
                Text(
                  "We offer a compassionate and stigma-free platform featuring original programming, insightful resources,and a nurturing global community.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
