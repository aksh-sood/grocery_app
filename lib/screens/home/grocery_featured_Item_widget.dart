import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'package:grocery_app/styles/colors.dart';
import 'home_screen.dart';

class GroceryFeaturedItem {
  final String name;
  final String imagePath;

  GroceryFeaturedItem(this.name, this.imagePath);
}


class GroceryFeaturedCard extends StatelessWidget {
  const GroceryFeaturedCard(this.groceryFeaturedItem,
      {this.color = AppColors.primaryColor});

  final GroceryFeaturedItem groceryFeaturedItem;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 110,
        height: 500,
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: color.withOpacity(0.25),
            borderRadius: BorderRadius.circular(18)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              height: getProportionateScreenHeight(40),
              width: getProportionateScreenWidth(50),
              image: AssetImage(groceryFeaturedItem.imagePath),
            ),
            SizedBox(
              height:5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AppText(
                text: groceryFeaturedItem.name,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
