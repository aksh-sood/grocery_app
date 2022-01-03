import 'package:flutter/material.dart';

class CarouselPage extends StatelessWidget {
  CarouselPage({
    Key key,
    @required this.image,
    @required this.asset,
  }) : super(key: key);
  final image;
  final asset;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: asset
              ? AssetImage(image)
              : Image.network(
                  image,
                ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
