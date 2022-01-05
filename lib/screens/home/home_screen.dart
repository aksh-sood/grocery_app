import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/widgets/grocery_item_card_widget.dart';
import 'grocery_featured_Item_widget.dart';
import 'home_banner_widget.dart';

List<GroceryFeaturedItem> groceryFeaturedItems = [
  GroceryFeaturedItem("Pulses", "assets/images/pulses.png"),
  GroceryFeaturedItem("Rice", "assets/images/rise.png"),
  GroceryFeaturedItem(
      "Meat & Fish", "assets/images/categories_images/meat.png"),
  GroceryFeaturedItem(
      "Bakery & Snacks", "assets/images/categories_images/bakery.png"),
];
List<String> bannerImages = [
  "assets/images/slider1.png",
  "assets/images/slider2.png"
];

class HomeScreen extends StatelessWidget {
  Future<dynamic> getProductsView(String tag) async {
    var l = await Product().getProductsCustom(tagId: tag, perPage: 20);
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  padded(HomeBanner(images: bannerImages, asset: true)),
                  SizedBox(
                    height: 25,
                  ),
                  padded(subTitle("Exclusive Order")),
                  FutureBuilder(
                      future: getProductsView("534"),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            height: 210.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                    color: AppColors.secondaryColor),
                              ],
                            ),
                          );
                        } else {
                          return getHorizontalItemSlider(snapshot.data);
                        }
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  padded(subTitle("Best Selling")),
                  FutureBuilder(
                      future: getProductsView("509"),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            height: 210.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                    color: AppColors.secondaryColor),
                              ],
                            ),
                          );
                        } else {
                          return getHorizontalItemSlider(snapshot.data);
                        }
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  padded(subTitle("Groceries")),
                  SizedBox(
                    height: 15,
                  ),
                  groceryList(),
                  SizedBox(
                    height: 15,
                  ),
                  FutureBuilder(
                      future: getProductsView("558"),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            height: 210.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                    color: AppColors.secondaryColor),
                              ],
                            ),
                          );
                        } else {
                          return getHorizontalItemSlider(snapshot.data);
                        }
                      }),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget groceryList() {
    return Container(
      height: 105,
      child: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        children: List.generate(groceryFeaturedItems.length, (index) {
          return GroceryFeaturedCard(groceryFeaturedItems[index],
              color: gridColors[index % gridColors.length]);
        }),
      ),
    );
  }

  Widget padded(Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: widget,
    );
  }

  Widget getHorizontalItemSlider(List<dynamic> items) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      height: 210.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // if(items[index].inStock){
          return GroceryItemCardWidget(
            item: items[index],
          );
          // }
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 10,
          );
        },
      ),
    );
  }

  Widget subTitle(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(
          "See All",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor),
        ),
      ],
    );
  }

  Widget locationWidget() {
    String locationIconPath = "assets/icons/location_icon.svg";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          locationIconPath,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          "Khartoum,Sudan",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
