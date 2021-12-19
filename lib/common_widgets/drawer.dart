import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/helpers/constants.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/category_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:grocery_app/widgets/category_item_card_widget.dart';

class CategoryDrawer extends StatelessWidget {
  CategoryDrawer({Key key, @required this.cat}) : super(key: key);
  List<Widget> drawerItem = [];
  final List<dynamic> cat;
  List categoryItemsDemo = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Row(
          children: [
            Container(
              color: AppColors.primaryColor,
              child: Column(
                children: [
                  Spacer(),
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          child: Text(
                            "C\n\nT\n\nA\n\nG\n\nO\n\nR\n\nI\n\nE\n\nS",
                            style: TextStyle(
                                color: AppColors.yellowColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          color: AppColors.primaryColor),
                    )
                  ]),
                  Spacer()
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: AppColors.whiteColor,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: cat.asMap().entries.map<Widget>((e) {
                        int index = e.key;
                        Cat categoryItem = e.value;
                        return GestureDetector(
                          onTap: () {
                            onCategoryItemClicked(context, categoryItem, cat);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: DrawerItem(
                              item: categoryItem,
                              color: gridColors[index % gridColors.length],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  DrawerItem({Key key, this.item, this.color}) : super(key: key);
  final Cat item;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(80),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            // child: Image.asset(item.image,
            //  scale: 10),
            child: item.image == null
                ? Image.asset("assets/images/categories_images/fruit.png",
                    scale: 10)
                : Image.network(
                    item.image,
                    scale: 10,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace stackTrace) {
                      return Image.asset(
                          "assets/images/categories_images/fruit.png",
                          scale: 10);
                    },
                  ),
            backgroundColor: color.withOpacity(0.1),
            radius: getProportionateScreenWidth(35),
          ),
          SizedBox(height: 10),
          Text(item.name,
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(color: AppColors.blackColor, fontSize: 15.sm)),
        ],
      ),
    );
  }
}

// Widget getStaggeredGridView(BuildContext context) {
//   return StaggeredGridView.count(
//     crossAxisCount: 4,
//     children: categoryItemsDemo.asMap().entries.map<Widget>((e) {
//       int index = e.key;
//       CategoryItem categoryItem = e.value;
//       return GestureDetector(
//         onTap: () {
//           onCategoryItemClicked(context, categoryItem);
//         },
//         child: Container(
//           padding: EdgeInsets.all(10),
//           child: CategoryItemCardWidget(
//             item: categoryItem,
//             color: gridColors[index % gridColors.length],
//           ),
//         ),
//       );
//     }).toList(),

//     //Here is the place that we are getting flexible/ dynamic card for various images
//     staggeredTiles: categoryItemsDemo
//         .map<StaggeredTile>((_) => StaggeredTile.fit(2))
//         .toList(),
//     mainAxisSpacing: 3.0,
//     crossAxisSpacing: 4.0, // add some space
//   );
// }
