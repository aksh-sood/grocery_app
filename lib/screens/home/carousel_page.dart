import 'package:flutter/material.dart';

class CarouselPage extends StatelessWidget {
  CarouselPage({
    Key key,
    @required this.image,
  }) : super(key: key);
  final image;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
