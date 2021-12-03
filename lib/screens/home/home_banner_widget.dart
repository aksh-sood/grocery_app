import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'carousel_page.dart';


class HomeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> pages=[];
    List<String> images=["assets/images/slider1.png","assets/images/slider2.png","assets/images/slider3","assets/images/banner_background.png"];
    for(int i=0;i<2;i++){
pages.add(  CarouselPage(image:images[i]));
    }
    return  CarouselSlider(
              items:pages,
              
            //Slider Container properties
              options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
          );
  }
}


