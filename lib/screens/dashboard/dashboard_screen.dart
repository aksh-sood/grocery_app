import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/common_widgets/drawer.dart';
import 'package:grocery_app/common_widgets/search_bar.dart';
import 'package:grocery_app/screens/account/account_screen.dart';
import 'package:grocery_app/screens/cart/cart_screen.dart';
import 'package:grocery_app/screens/explore_screen.dart';
import 'package:grocery_app/screens/home/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../favourite_screen.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/woo/config.dart';
import 'navigator_item.dart';

class DashboardScreen extends StatefulWidget {
  final List cat;
  DashboardScreen({this.cat});
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;
  String token = Config.token;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool _searching = false;
  List<Cat> mainCat = [];
  List<Cat> cats;
  List<Cat> data = [];
  Box box;
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
      data.add(Cat(name: "null"));
    } else {
      data = cats;
    }
    return Future.value(true);
  }

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<NavigatorItem> navigatorItems = [
      NavigatorItem("Shop", "assets/icons/shop_icon.svg", 0, HomeScreen()),
      NavigatorItem(
          "Explore", "assets/icons/explore_icon.svg", 1, ExploreScreen()),
      NavigatorItem("Cart", "assets/icons/cart_icon.svg", 2, CartScreen()),
      NavigatorItem(
          "Favourite", "assets/icons/favourite_icon.svg", 3, FavouriteScreen()),
      NavigatorItem(
          "Account", "assets/icons/account_icon.svg", 4, AccountScreen()),
    ];
    return MultiProvider(
      providers: [
        FutureProvider<List<Cat>>(
            initialData: mainCat, create: (context) => sortCats()),
      ],
      child: Scaffold(
        key: _key,
        drawer: mainCat == []
            ?
            // FutureBuilder<Object>(
            //     future: sortCats(),
            //     builder: (context, snapshot) {
            // if (snapshot.data == null) {
            //   return
            Container(
                width: 180.w,
                height: MediaQuery.of(context).size.height,
                color: AppColors.whiteColor,
                child: Row(
                  children: [
                    Container(
                      color: AppColors.primaryColor,
                      child: Column(
                        children: [
                          Spacer(),
                          Row(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                    Container(
                      width: 140.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                              color: AppColors.secondaryColor),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            // } else {
            // return
            : CategoryDrawer()
        //     ;
        //   }
        // })
        ,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                backgroundColor: AppColors.blackColor,
                child: IconButton(
                  icon: Icon(Icons.search, color: AppColors.whiteShader),
                  onPressed: () {
                    setState(() {
                      _searching = !_searching;
                    });
                  },
                  tooltip: 'Search',
                ),
              ),
            ),
          ],
          leading: GestureDetector(
            onTap: () {
              _key.currentState.openDrawer();
            },
            child: Row(
              children: [
                SizedBox(width: getProportionateScreenWidth(5)),
                IconButton(
                  onPressed: null,
                  icon: Image.asset("assets/icons/marketspalsh.png"),
                  iconSize: 30,
                )
              ],
            ),
          ),
          titleSpacing: 0,
          title: _searching
              ? Container(
                  height: getProportionateScreenHeight(40),
                  // margin: const EdgeInsets.symmetric(
                  //   horizontal: 15,
                  // ),
                  child: Center(
                    child: SearchBar(
                      isSearching: _searching,
                    ),
                  ),
                )
              : Row(
                  children: [
                    SvgPicture.asset("assets/icons/app_bar_lead.svg"),
                    //  SizedBox(width: getProportionateScreenWidth(40)),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Location",
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 15)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on),
                            Text("Brooklyn Home",
                                style: TextStyle(
                                    color: AppColors.blackColor, fontSize: 15)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
        ),
        body: navigatorItems[currentIndex].screen,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 37,
                  offset: Offset(0, -12)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.primaryColor,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
              unselectedItemColor: Colors.black,
              items: navigatorItems.map((e) {
                return getNavigationBarItem(
                    label: e.label, index: e.index, iconPath: e.iconPath);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem getNavigationBarItem(
      {String label, String iconPath, int index}) {
    Color iconColor =
        index == currentIndex ? AppColors.primaryColor : Colors.black;
    setState(() {
      _searching = false;
    });
    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(
        iconPath,
        color: iconColor,
      ),
    );
  }
}
