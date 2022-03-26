import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/models/tag.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/widgets/grocery_item_card_widget.dart';
import 'package:grocery_app/models/category.dart';
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
  // Future<dynamic> getProductsView(String tag) async {
  //   List l = [];
  //   var exProductsJson = await Product().getScrollProducts(tag);

  //   for (var json in exProductsJson) {
  //     List<Tag> tags = [];
  //     List<String> images = [];
  //     List<Cat> categories = [];
  //     if (json["categories"] != null) {
  //       json["categories"].forEach((v) {
  //         categories
  //             .add(new Cat(id: v["id"], name: v["name"], slug: v["slug"]));
  //       });
  //     }
  //     if (json["tags"] != null) {
  //       json["tags"].forEach((t) {
  //         tags.add(new Tag(id: t["id"], name: t["name"], slug: t["slug"]));
  //       });
  //     }
  //     if (json["images"] != null) {
  //       json["images"].forEach((i) {
  //         images.add(i["src"]);
  //       });
  //     }
  //     l.add(new Product(
  //         id: json["id"],
  //         name: json["name"],
  //         description: json["description"],
  //         shortDescription: json["short_description"],
  //         slug: json["slug"],
  //         onSale: json["on_sale"],
  //         sku: json["sku"],
  //         permaLink: json["permalink"],
  //         price: json["price"],
  //         regularPrice: json["regular_price"],
  //         salePrice: json["sale_price"],
  //         stockStatus: json["stock_status"],
  //         images: images,
  //         categories: categories,
  //         tags: tags));
  //   }
  //   return l;
  // }

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
                  HomeBanner(images: bannerImages, asset: true),
                  SizedBox(
                    height: 25,
                  ),
                  padded(subTitle("Exclusive Order")),
                  FutureBuilder(
                      future: Product()
                          .getProductsCustom(tagId: "534", perPage: 20),
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
                      future: Product()
                          .getProductsCustom(tagId: "509", perPage: 20),
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
                      future: Product()
                          .getProductsCustom(tagId: "558", perPage: 20),
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
      padding: EdgeInsets.symmetric(horizontal: 25),
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
