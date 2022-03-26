import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/screens/product_details/product_details_screen.dart';
import 'package:grocery_app/styles/colors.dart';

class GroceryItemCardWidget extends StatelessWidget {
  GroceryItemCardWidget({Key key, this.item}) : super(key: key);
  final Product item;

  final double width = 150.w;
  final double height = 250.h;
  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18.r;

  @override
  Widget build(BuildContext context) {
    int percentOff;
    if (item.onSale) {
      percentOff =
          ((double.parse(item.salePrice) / double.parse(item.price)) * 100)
              .round();
    }
    if (percentOff == 100.0) {
      item.onSale = false;
    }
    return Stack(children: [
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 15.h,
          ),
          child: GestureDetector(
            onTap: () => onItemClicked(context, item),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: imageWidget(),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  height: getProportionateScreenHeight(40),
                  child: AppText(
                    text: item.name,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: AppText(
                    text: item.description,
                    fontSize: 13.sp,
                    // fontWeight: FontWeight.w600,
                    color: Color(0xFF7C7C7C),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "د.إ${item.price}",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    addWidget()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      // Positioned(child: addWidget(),top:0,right:0),
      Container(
        height: 23.h,
        width: 70.w,
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        decoration: BoxDecoration(
            color: item.onSale
                ? Colors.red[600].withOpacity(0.85)
                : Colors.transparent,
            border: Border.all(
              color: item.onSale
                  ? Colors.red[600].withOpacity(0.8)
                  : Colors.transparent,
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                bottomRight: Radius.circular(borderRadius))),
        child: Text("${percentOff}% OFF",
            softWrap: false,
            style: TextStyle(
                color: item.onSale ? AppColors.whiteColor : Colors.transparent,
                fontSize: 12.sm)),
      ),
    ]);
  }

  void onItemClicked(BuildContext context, Product productItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(productItem)),
    );
  }

  Widget imageWidget() {
    return Container(
      color: AppColors.whiteColor,
      child: CachedNetworkImage(
        // fit: BoxFit.fitHeight,
        height: 90.h,
        imageUrl: item.images[0],
        placeholder: (context, url) => Center(
          child: Text(
            "Loading...",
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget addWidget() {
    return GestureDetector(
      onTap: () => print("added"),
      child: Container(
        height: 30.h,
        width: 30.h,
        decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(5.r),
            color: AppColors.primaryColor),
        child: Center(
          child: Icon(
            Icons.add,
            color: AppColors.whiteColor,
            size: 18.r,
          ),
        ),
      ),
    );
  }
}
