import 'package:flutter/material.dart';
import 'package:grocery_app/categoryItemsPage/category_items_screen.dart';
import 'package:grocery_app/common_widgets/drawer.dart';
import 'package:grocery_app/helpers/constants.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/category_item.dart';
import 'package:grocery_app/styles/colors.dart';

class SubCategoryScreen extends StatefulWidget {
  SubCategoryScreen({Key key, @required this.headCat, @required this.preVal})
      : super(key: key);
  Cat headCat;
  Cat preVal;
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
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(8),
                    width: SizeConfig.screenWidth / 2,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(8),
                        )),
                    child: CatTile(
                        cat: Cat(name: "Sub Categories"),
                        inVal: Cat(name: "."))),
                Container(
                  height: SizeConfig.screenHeight / 4,
                  width: SizeConfig.screenWidth / 2,
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
                        // int index = e.key;
                        // CategoryItem categoryItem = e.value;
                        return Container(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: CatTile(
                            cat: e.value,
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
    );
  }
}

class CatTile extends StatelessWidget {
  CatTile({Key key, @required this.cat, @required this.inVal})
      : super(key: key);
  final Cat cat;
  final Cat inVal;
  Cat outVal;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        outVal = cat;

        Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) {
            return CategoryItemsScreen(disVal: outVal, cat: inVal.subCat);
          },
        ));
      },
      child: Container(
          // height: ,
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
            child: Text(cat.name,
                softWrap: true,
                style: TextStyle(
                    color: cat == inVal ? Colors.purple : Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      )),
    );
  }
}
