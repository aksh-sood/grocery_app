import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:grocery_app/common_widgets/drawer.dart';
import 'package:grocery_app/helpers/constants.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/category_item.dart';
import 'package:grocery_app/screens/categoryItemsPage/category_items_screen.dart';
import 'package:grocery_app/styles/colors.dart';

class SubCategoryScreen extends StatefulWidget {
  SubCategoryScreen(
      {Key key,
      @required this.headCat,
      @required this.preVal,
      @required this.allCat})
      : super(key: key);
  Cat headCat;
  Cat preVal;
  final List<dynamic> allCat;
  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  static String selVal;
  goBack() {
    Navigator.pop(context, selVal);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(15, 8, 0, 8),
                      width: SizeConfig.screenWidth / 1.5,
                      decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          )),
                      child: Text("Sub Categories",
                          style: TextStyle(
                            color: AppColors.yellowColor,
                            fontSize: 17.sm,
                            fontFamily: "Poppins",
                          ))),
                  Container(
                    height: SizeConfig.screenHeight / 4,
                    width: SizeConfig.screenWidth / 1.5,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        )),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: widget.headCat.subCat
                            .asMap()
                            .entries
                            .map<Widget>((e) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: CatTile(
                              headCat: widget.headCat,
                              cat: e.value,
                              allCat: widget.allCat,
                              inVal: widget.preVal,
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
      ),
    );
  }
}

class CatTile extends StatelessWidget {
  CatTile(
      {Key key,
      @required this.cat,
      @required this.inVal,
      this.headCat,
      this.allCat})
      : super(key: key);
  final Cat cat;
  final List<dynamic> allCat;
  final Cat headCat;
  final Cat inVal;
  Cat outVal;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        outVal = cat;

        Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) {
            return CategoryItemsScreen(
              disVal: headCat,
              cat: allCat,
              subDisVal: outVal,
            );
          },
        ));
      },
      child: Container(
          child: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: cat == inVal ? Colors.purple : Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  )),
              width: 7,
              height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              cat.name,
              softWrap: true,
              style: TextStyle(
                  color: cat == inVal ? Colors.purple : Colors.black,
                  fontSize: 13.sm,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      )),
    );
  }
}
