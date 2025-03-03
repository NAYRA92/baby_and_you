import 'package:baby_and_you/home_page.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'onboarding_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby&You',
      theme: ThemeData(
        fontFamily: "Ubuntu",
        colorScheme: ColorScheme.fromSeed(seedColor: kFern_green),
        useMaterial3: true,
      ),
      home: OnboardingPage(),
    );
  }
}