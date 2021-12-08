import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'package:grocery_app/screens/sign_in/sign_in_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

// ------------------ Custom config ------------------
class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
 slides.add(
      new Slide(
        backgroundImage:"assets/images/slider1.png",
        backgroundOpacity: 0,
      ),
    );
  slides.add(
      new Slide(
        backgroundImage:"assets/images/slider2.png",
        backgroundOpacity: 0,
      ),
    ); slides.add(
      new Slide(
        backgroundImage:"assets/images/slider3.png",
        backgroundOpacity: 0,
      ),
    );
  }

  void onDonePress() {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }
Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: AppColors.primaryColor,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: AppColors.primaryColor,
    );
  }


  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(AppColors.whiteShader),
      overlayColor: MaterialStateProperty.all<Color>(AppColors.whiteColor),
    );
  }


  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      showNextBtn: false,
      showPrevBtn: false,
      renderSkipBtn: this.renderSkipBtn(),
       skipButtonStyle: myButtonStyle(),
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      doneButtonStyle: myButtonStyle(),
      colorDot: AppColors.whiteShader.withOpacity(0.5),
      colorActiveDot:AppColors.whiteShader ,
      sizeDot: 13.0,
      hideStatusBar: true,
      backgroundColorAllSlides: AppColors.primaryColor,
      verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
    );
  }
} 