import 'package:flutter/material.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'package:grocery_app/screens/sign_up/sign_up_screen.dart';
import 'package:grocery_app/styles/colors.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) =>  SignUpScreen(),
    ),
  ),
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
