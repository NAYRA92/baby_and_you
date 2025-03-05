import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:baby_and_you/constants.dart';
import 'package:baby_and_you/onboarding_page.dart';
import 'package:flutter/material.dart';

class LogoPage extends StatelessWidget {
  const LogoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingPage()));
    });
    return Scaffold(
      backgroundColor: kHoneydew,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "BABY&YOU",
            style: TextStyle(fontFamily: "Sigmar", fontSize: 36),
          ),
          Text(
            "The Ultimate AI Driven Assistant",
            style: TextStyle(fontSize: 18),
          ),
        ],
      )
    ),
    bottomNavigationBar: BottomAppBar(
      color: kHoneydew,
      child: Text(
        "A PROJECT BY NAYRA HASHEM FOR\nCREATE HER FEST 2025 HACKATHON.\n #createHerFest",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14
        ),),
    ),
    );
  }
}
