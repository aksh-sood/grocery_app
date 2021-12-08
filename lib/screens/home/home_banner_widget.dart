import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'carousel_page.dart';


class HomeBanner extends StatefulWidget {
  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  final CarouselController _controller = CarouselController();

  int _current=0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages=[];
    List<String> images=["assets/images/slider1.png","assets/images/slider2.png"];
    for(int i=0;i<2;i++){
pages.add(  CarouselPage(image:images[i]));
    }
    return  Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
                  items:pages,
                  carouselController: _controller,
                //Slider Container properties
                  options: CarouselOptions(
                    onPageChanged:(index, reason) {
                      setState(() {
                        _current = index;
                      });
                    } ,
                    height: 180.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 2,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 1,
                  ),
              ),
     Positioned(
       bottom: getProportionateScreenHeight(7),
       child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Align(
                  child: Container(
                    width:_current == entry.key ? 15.0:10,
                    height: _current == entry.key ?7.5:10,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        // shape: BoxShape.circle
                        borderRadius:
                   BorderRadius.all(Radius.circular(5)),
                        color: 
                                 Colors.white
                                 
                            .withOpacity(_current == entry.key ? 0.9 : 0.5)),
                  ),
                ),
              );
            }).toList(),
          ),
     ),
      ],
    );
  }
}


