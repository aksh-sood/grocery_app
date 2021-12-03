import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  //One instance, needs factory
  static AppColors _instance;
  factory AppColors() => _instance ??= AppColors._();

  AppColors._();

  static const secondaryColor = Color(0xFF517d14);
  static const primaryColor = Color(0xFF5b8c16);
  static const yellowColor = Color(0xFFffd200);
  static const whiteShader = Color(0xfff4f4f4);
  static const greyShader = Color(0xff7C7C7C);
  static const whiteColor = Color(0xffffffff);
  static const blackColor = Colors.black;
  static const redColor = Colors.red;
}
List<Color> gridColors = [
  Color(0xff53B175),
  Color(0xffF8A44C),
  Color(0xffF7A593),
  Color(0xffD3B0E0),
  Color(0xffFDE598),
  Color(0xffB7DFF5),
  Color(0xff836AF6),
  Color(0xffD73B77),
];