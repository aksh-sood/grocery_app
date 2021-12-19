import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/common_widgets/default_button.dart';
import 'package:grocery_app/helpers/constants.dart';
import 'package:grocery_app/helpers/form_error.dart';
import 'package:grocery_app/helpers/keyboard.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/customer_model.dart';
import 'package:grocery_app/screens/dashboard/dashboard_screen.dart';
import 'package:grocery_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:grocery_app/widgets/custom_surfix_icon.dart';
import 'package:grocery_app/woo/config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  bool isApiCallProcess = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void initState() {
    super.initState();
  }

  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          TextFormField(
            obscureText: obscure,
            onChanged: (value) {
              password = value;
              if (value.isEmpty) {
                removeError(error: kPassNullError);
              } else if (value.length >= 8) {
                removeError(error: kShortPassError);
              }
              password = value;
            },
            validator: (value) {
              if (value.isEmpty) {
                addError(error: kPassNullError);
                return "";
              } else if (value.length < 8) {
                addError(error: kShortPassError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: IconButton(
                  icon: Icon(obscure ? Icons.visibility_off : Icons.visibility,
                      color: kPrimaryColor),
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  }),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ForgotPasswordScreen(),
                  ),
                ),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColors.secondaryColor),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () async {
              // if (_formKey.currentState.validate()) {
              //   setState(() {
              //     isApiCallProcess = true;
              //   });
              //   _formKey.currentState.save();
              //   KeyboardUtil.hideKeyboard(context);
              //   CustomerModel model =
              //       CustomerModel.b(email: email, password: password);
              //   var response = await model.loginUser();
              //   if (response["success"] != "no") {
              //     if (response["success"]) {
              //       Config.token = response["data"]["token"];
              List<dynamic> allCats = await Cat().getAllCats();
              Fluttertoast.showToast(
                  msg: "Welcome back $email",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.grey[850],
                  textColor: AppColors.whiteColor,
                  fontSize: 16.0);
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      DashboardScreen(cat: allCats),
                ),
              );
              //       } else {
              //         String msg = removeAllHtmlTags(response["message"]);
              //         Fluttertoast.showToast(
              //             msg: "$msg",
              //             toastLength: Toast.LENGTH_SHORT,
              //             gravity: ToastGravity.BOTTOM,
              //             timeInSecForIosWeb: 5,
              //             backgroundColor: Colors.grey[850],
              //             textColor: AppColors.whiteColor,
              //             fontSize: 16.0);
              //       }
              //     } else {
              //       Fluttertoast.showToast(
              //           msg: "Error Occured please try later",
              //           toastLength: Toast.LENGTH_SHORT,
              //           gravity: ToastGravity.BOTTOM,
              //           timeInSecForIosWeb: 5,
              //           backgroundColor: Colors.grey[850],
              //           textColor: AppColors.whiteColor,
              //           fontSize: 16.0);
              //     }
              //   } else {
              //     Fluttertoast.showToast(
              //         msg: "Details Not Valid, Please check again",
              //         toastLength: Toast.LENGTH_SHORT,
              //         gravity: ToastGravity.BOTTOM,
              //         timeInSecForIosWeb: 5,
              //         backgroundColor: Colors.grey[850],
              //         textColor: AppColors.whiteColor,
              //         fontSize: 16.0);
              //   }

              //   setState(() {
              //     isApiCallProcess = false;
              //   });
            },
          ),
          SizedBox(height: 18.h),
          TextButton(
            onPressed: () async {
              List<dynamic> allCats = await Cat().getAllCats();
              Fluttertoast.showToast(
                  msg: "Welcome to YourGrocer",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.grey[850],
                  textColor: AppColors.whiteColor,
                  fontSize: 16.0);
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      DashboardScreen(cat: allCats),
                ),
              );
            },
            child: Text(
              "Continue as Guest",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: AppColors.secondaryColor),
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) {
        password = value;
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        email = value;
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
