import 'dart:developer';
import 'package:grocery_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/helpers/constants.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/category_item.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:grocery_app/widgets/category_item_card_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatelessWidget {
  Box box;

  List cats;
  List data = [];
  final List<String> errors = [];

  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    log(dir.path, name: "path");
    Hive.init(dir.path);
    box = await Hive.openBox("data");
  }

  Future putData(productList) async {
    await box.clear();
    // box.
    for (var p in productList) {
      box.add(p);
    }
  }

  Future cacheProductData(cat) async {
    await openBox();
    try {
      await putData(cat);
    } catch (e) {
      print("error");
      print(e.message);
    }
    cats = box.toMap().values.toList();
    print(cats);
    if (cats.isEmpty) {
      data.add("empty");
    } else {
      data = cats;
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    List<Cat> mainCat = Provider.of<List<Cat>>(context);

    Future<List> sortCats() async {
      if (mainCat.length == 0) {
        List<dynamic> allcats = await Cat().getAllCats();
        for (var c in allcats) {
          if (c["parent"] == 0) {
            mainCat.add(Cat(
                id: c["id"],
                name: c["name"],
                slug: c["slug"],
                image: c["image"],
                count: c["count"],
                subCat: []));
          }
        }

        for (var m in mainCat) {
          for (var c in allcats) {
            if (m.id == c["parent"]) {
              m.subCat.add(Cat(
                  id: c["id"],
                  name: c["name"],
                  slug: c["slug"],
                  image: c["image"],
                  count: c["count"],
                  subCat: null));
            }
          }
        }

        // await cacheProductData(mainCat);

        return Future.value(mainCat);
      } else {
        return Future.value(mainCat);
      }
    }

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          getHeader(),
          mainCat == []
              ?
              // FutureBuilder(
              //     future: sortCats(),
              //     builder: (context, snapshot) {
              //       if (snapshot.data == null) {
              //         return
              Container(
                  height: 30.h,
                  width: 30.h,
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                )
              :
              //   ;
              // } else {
              //   return
              Expanded(
                  child: StaggeredGridView.count(
                    crossAxisCount: 3,
                    children: mainCat.asMap().entries.map<Widget>((e) {
                      int index = e.key;
                      Cat categoryItem = e.value;
                      return GestureDetector(
                        onTap: () {
                          onCategoryItemClicked(context, categoryItem, mainCat);
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          child: CategoryItemCardWidget(
                            item: categoryItem,
                            color: gridColors[index % gridColors.length],
                          ),
                        ),
                      );
                    }).toList(),

                    //Here is the place that we are getting flexible/ dynamic card for various images
                    staggeredTiles: mainCat
                        .map<StaggeredTile>((_) => StaggeredTile.fit(1))
                        .toList(),
                    mainAxisSpacing: 3.0,
                    crossAxisSpacing: 4.0, // add some space
                  ),
                ),
          //   ;}
          // })
        ],
      ),
    ));
  }

  Widget getHeader() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: AppText(
            text: "Find Products",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  // Widget getStaggeredGridView(BuildContext context) {
  //   return FutureBuilder(
  //       future: sortCats(),
  //       builder: (context, snapshot) {
  //         if (snapshot.data == null) {
  //           return Container(
  //             height: 30.h,
  //             width: 30.h,
  //             child: CircularProgressIndicator(
  //               color: AppColors.primaryColor,
  //             ),
  //           );
  //         } else {
  //           return Expanded(
  //             child: StaggeredGridView.count(
  //               crossAxisCount: 3,
  //               children: mainCat.asMap().entries.map<Widget>((e) {
  //                 int index = e.key;
  //                 Cat categoryItem = e.value;
  //                 return GestureDetector(
  //                   onTap: () {
  //                     onCategoryItemClicked(context, categoryItem, mainCat);
  //                   },
  //                   child: Container(
  //                     padding: EdgeInsets.all(4),
  //                     child: CategoryItemCardWidget(
  //                       item: categoryItem,
  //                       color: gridColors[index % gridColors.length],
  //                     ),
  //                   ),
  //                 );
  //               }).toList(),

  //               //Here is the place that we are getting flexible/ dynamic card for various images
  //               staggeredTiles: mainCat
  //                   .map<StaggeredTile>((_) => StaggeredTile.fit(1))
  //                   .toList(),
  //               mainAxisSpacing: 3.0,
  //               crossAxisSpacing: 4.0, // add some space
  //             ),
  //           );
  //         }
  //       });
  // }

  // // void onCategoryItemClicked(BuildContext context, CategoryItem categoryItem) {
  //   Navigator.of(context).push(new MaterialPageRoute(
  //     builder: (BuildContext context) {
  //       return CategoryItemsScreen(disVal:categoryItem.name);
  //     },
  //   ));
  // }
}
