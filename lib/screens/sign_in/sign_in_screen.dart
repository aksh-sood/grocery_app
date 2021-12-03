import 'package:flutter/material.dart';
import 'package:grocery_app/helpers/constants.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'package:grocery_app/styles/colors.dart';

import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // centerTitle: true,
          title: Text("Sign In",style:TextStyle(color:AppColors.blackColor,fontSize:getProportionateScreenHeight(30))),
        ),
        body: Body(),
      ),
    );
  }
}
