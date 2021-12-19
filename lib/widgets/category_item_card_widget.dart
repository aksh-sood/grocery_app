import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/category_item.dart';

class CategoryItemCardWidget extends StatelessWidget {
  CategoryItemCardWidget({Key key, this.item, this.color = Colors.blue})
      : super(key: key);
  final Cat item;

  final height = 125.0;

  final width = 125.0;

  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withOpacity(0.7),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: 70,
            child: imageWidget(),
          ),
          SizedBox(
            height: 60,
            child: Center(
              child: AppText(
                text: item.name,
                textAlign: TextAlign.center,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      child: item.image == null
          ? Image.asset("assets/images/categories_images/fruit.png", scale: 10)
          : Image.network(
              item.image,
              scale: 10,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace stackTrace) {
                return Image.asset("assets/images/categories_images/fruit.png",
                    scale: 10);
              },
            ),
    );
  }
}
