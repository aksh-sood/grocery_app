import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'package:grocery_app/screens/welcome_screen.dart';
import 'package:grocery_app/screens/welcomeslider/slider1.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    const delay = const Duration(seconds: 3);
    Future.delayed(delay, () => onTimerFinished());
  }

  void onTimerFinished() {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) {
        return IntroScreen();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: splashScreenIcon(context),
      ),
    );
  }
}

Widget splashScreenIcon(context) {
  String iconPath = "assets/icons/marketspalsh.png";
  String textPath = "assets/icons/yourgrocer.png";
  return 
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(iconPath),
      SizedBox(height:getProportionateScreenHeight(10)) ,
      Image.asset(textPath),

    ],
  );
}
