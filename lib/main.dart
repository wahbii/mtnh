import 'package:flutter/material.dart';
import 'package:mtnh/screens/home/homescreenn.dart';
import 'package:mtnh/screens/onboarding/onboardingscreen.dart';
import 'package:mtnh/screens/splash/spalshscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mhtn',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.path,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '${SplashScreen.path}': (context) => SplashScreen(),
        '${OnBoardingScreen.path}': (context) =>OnBoardingScreen(),
        '${HomeScreen.path}': (context) =>HomeScreen(),


        // When navigating to the "/second" route, build the SecondScreen widget.

      },
    );
  }
}
