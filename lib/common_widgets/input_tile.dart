import "package:flutter/material.dart";

import 'package:flutter/services.dart';
import 'package:grocery_app/helpers/constants.dart';
import 'package:grocery_app/styles/colors.dart';

//created by aksh
// ignore: must_be_immutable
class InputTile extends StatelessWidget {
  InputTile(
      {this.isObscure = false,
      this.startIcon,
      this.tileIcon,
      @required this.inputType,
      @required this.callBack,
      this.textLength,
      this.tapCall,
      this.keyboard,
      this.setValidator,
      this.seeOnly = false,
      this.control});
  Icon startIcon;
  Function setValidator;
  Function callBack;
  Function tapCall;
  final String inputType;
  final bool isObscure;
  var control;
  bool seeOnly;
  final TextInputType keyboard;
  final IconButton tileIcon;
  final List<TextInputFormatter> textLength;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      inputFormatters: textLength,
      style: kTextFieldStyle,
      controller: control,
      readOnly: seeOnly,
      cursorColor: kPrimaryColor,
      validator: setValidator,
      onChanged: callBack,
      onTap: tapCall,
      obscureText: isObscure,
      decoration: InputDecoration(
        fillColor: AppColors.whiteShader,
        prefixIcon: startIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: kTextFieldBorderRadius,
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
        ),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: kTextFieldBorderRadius,
          borderSide:
              const BorderSide(color: AppColors.secondaryColor, width: 1),
        ),
        hintText: inputType,
        hintStyle: kHintTextStyle,
        suffixIcon: tileIcon,
        border: OutlineInputBorder(
          borderRadius: kTextFieldBorderRadius,
          borderSide: BorderSide(color: AppColors.blackColor, width: 1),
        ),
      ),
    );
  }
}
