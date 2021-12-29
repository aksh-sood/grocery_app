import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/category_item.dart';
import 'package:grocery_app/categoryItemsPage/category_items_screen.dart';
import 'package:grocery_app/styles/colors.dart';

const kPrimaryColor = Color(0xFF517d14);
const kPrimaryLightColor = Color(0xFF5b8c16);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFffd200), Color(0xFF5b8c16)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kLastNameNullError = "Please Enter your last name";
const String kAddressNullError = "Please Enter your address";
var kTextFieldBorderRadius = BorderRadius.all(Radius.circular(18.0.r));
var kHintTextStyle = TextStyle(color: AppColors.blackColor, fontSize: 15.sm);
var kTextFieldStyle = TextStyle(color: AppColors.blackColor, fontSize: 18.0.sm);

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<.*?>|&([a-z0-9]+|#[0-9]{1,6}|#x[0-9a-f]{1,6});",
      multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}

//  appBarDesign(var key) {
//     return AppBar(
//   //  automaticallyImplyLeading: false,
//    actions: [  IconButton(
//             icon: Icon(Icons.search, color: Colors.white),
//             onPressed: () {
//               setState(() {
//                 _searching = !_searching;
//               });
//             },
//             tooltip: 'Search',
//           ),],
//   leading: GestureDetector(
//     onTap: (){
// key.currentState.openDrawer();
//     },
//     child: Row(
//       children: [
//        SizedBox(width: getProportionateScreenWidth(5)),
//        IconButton(onPressed:null, icon: Image.asset("assets/icons/marketspalsh.png"),iconSize: 30,)

//       ],
//     ),
//   ),
//   titleSpacing: 0,
//   title:Row(children: [SvgPicture.asset("assets/icons/app_bar_lead.svg"),
//     //  SizedBox(width: getProportionateScreenWidth(40)),
//     Spacer(),
//      Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.end,
//        children: [
//          Text("Location",style: TextStyle(color: AppColors.primaryColor,fontSize: 15)),

//          Row(
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: [
//              Icon(Icons.location_on),
//              Text("Brooklyn Home",style: TextStyle(color: AppColors.blackColor,fontSize: 15)),
//            ],
//          ),
//        ],
//      ),

//      ],),
//     );
//   }

void onCategoryItemClicked(BuildContext context, Cat categoryItem, List cat) {
  Navigator.of(context).push(new MaterialPageRoute(
    builder: (BuildContext context) {
      return CategoryItemsScreen(
        disVal: categoryItem,
        cat: cat,
      );
    },
  ));
}
