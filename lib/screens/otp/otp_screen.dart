import 'package:flutter/material.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  String phoneNumber;
  OtpScreen({@required this.phoneNumber});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Body(phoneNumber:phoneNumber),
    );
  }
}
