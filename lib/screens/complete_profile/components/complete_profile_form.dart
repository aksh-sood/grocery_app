import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/default_button.dart';
// import 'package:grocery_app/helpers/api_helper.dart';
import 'package:grocery_app/helpers/constants.dart';
import 'package:grocery_app/helpers/form_error.dart';
import 'package:grocery_app/helpers/progressHUD.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'package:grocery_app/models/customer.dart';
import 'package:grocery_app/screens/sign_in/sign_in_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:grocery_app/widgets/custom_surfix_icon.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CompleteProfileForm extends StatefulWidget {
  CompleteProfileForm({@required this.email,@required this.password});
  String email,password;
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String firstName;
  String lastName;
  String phoneNumber;
  String address;
 
  bool isApiCallProcess=false;

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () async{
  setState(() {
    isApiCallProcess=true;
  });
              if (_formKey.currentState.validate()) {
              CustomerModel  model=new CustomerModel.a(email:widget.email,firstName:firstName,lastName: lastName,password: widget.password);
       
                print(model.toJson());
                
  String jsonUser = jsonEncode(model);
  print(jsonUser);
                       print("555555555555555555555555555555555555555555555555555555555555555555555555555555555555555");   
                            
var  response= await model.createUser(
  // '{"email":"${widget.email}","first_name":"${firstName}","last_name": "$lastName","password":"${widget.password}","username": "${widget.email}"}'
 jsonUser
  );
        //  log(response["message"].toString(),name:"tyu");
 String msg=removeAllHtmlTags(response["message"]);
 
if (
  response["success"]!="no"
){

  try{
   if (response["email"]==widget.email){
       Fluttertoast.showToast(
                                            msg: "Account created successfully",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 5,
                                            backgroundColor:
                                                Colors.grey[850],
                                            textColor: AppColors.whiteColor,
                                            fontSize: 16.0);

                                             Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );}
  }finally{
       Fluttertoast.showToast(
                                            msg: "$msg",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 5,
                                            backgroundColor:
                                                Colors.grey[850],
                                            textColor: AppColors.whiteColor,
                                            fontSize: 16.0);

                                             Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

         
                                            }else{


            Fluttertoast.showToast(
                                            msg: "Error Occured please try later",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 5,
                                            backgroundColor:
                                                Colors.grey[850],
                                            textColor: AppColors.whiteColor,
                                            fontSize: 16.0);
                                            }

                                        
        
              }else {
            Fluttertoast.showToast(
                                            msg: "Details Not Valid, Please check again",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 5,
                                            backgroundColor:
                                                Colors.grey[850],
                                            textColor: AppColors.whiteColor,
                                            fontSize: 16.0);}
                                            
                                             Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );

              setState(() {
    isApiCallProcess=false;
  });
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(

      onChanged: (value) {
        address = value;
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your phone address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {

    return TextFormField(
      keyboardType: TextInputType.phone,
   
      onChanged: (value) {
        phoneNumber=value;
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
onChanged: (value) {
        lastName=value;
        if (value.isNotEmpty) {
          removeError(error: kLastNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kLastNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onChanged: (value) {
        firstName=value;
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
