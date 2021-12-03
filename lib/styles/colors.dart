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
  static const whiteColor = Color(0xffffffff);
  static const blackColor = Colors.black;
}
