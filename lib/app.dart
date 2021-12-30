import 'package:flutter/material.dart';
import 'package:grocery_app/screens/splash_screen.dart';
import 'helpers/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(426, 900),
        builder: () {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme(),
            home: SplashScreen(),
          );
        });
  }
}
