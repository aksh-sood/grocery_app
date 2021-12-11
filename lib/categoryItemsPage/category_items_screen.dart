import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/categoryItemsPage/sub_category_screen.dart';
import 'package:grocery_app/common_widgets/drawer.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/screens/product_details/product_details_screen.dart';
import 'package:grocery_app/widgets/grocery_item_card_widget.dart';
import 'package:grocery_app/helpers/constants.dart';
import 'package:grocery_app/models/category_item.dart';
import 'package:grocery_app/styles/colors.dart';
import '../screens/filter_screen.dart';

class CategoryItemsScreen extends StatefulWidget {
  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
   final GlobalKey<ScaffoldState> _key = GlobalKey();
    List<String> _subCategories=["Fruits and Vegetables","Breads","Juices"];
        GlobalKey colKey;
        double colWidth ;
void calculateColWidth() {
  WidgetsBinding.instance.addPostFrameCallback((_) { 
    final RenderBox box=colKey.currentContext.findRenderObject();

setState(() {
  colWidth=    box.size.width;
});

  });
}
@override
void initState() {
  calculateColWidth();
  super.initState();
  
}
  @override
  Widget build(BuildContext context) {
    
     String _subCategory=_subCategories[0];
     void GoToCategory(BuildContext context)async{
 _subCategory=await    
Navigator.push(context, MaterialPageRoute(builder: (context) =>SubCategoryScreen(subCat:_subCategories,preVal: _subCategory,)));

}

    return Scaffold(
       key: _key,
       drawer: CategoryDrawer(),
      appBar: AppBar(
    titleSpacing: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.only(left: 25),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilterScreen()),
              );
            },
            child: Container(
              padding: EdgeInsets.only(right: 25),
              child: Icon(
                Icons.sort,
                color: Colors.black,
              ),
            ),
          ),
        ],
        title: GestureDetector(
          onTap: () {
      GoToCategory(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child:RichText(
  text: TextSpan(
    text: _subCategory,
    style: TextStyle(fontSize: 15,color:Colors.black,fontWeight: FontWeight.bold),
    children: const <TextSpan>[
        TextSpan(text: '  (1000 items)', style: TextStyle(fontSize: 12,color: Colors.grey)),
      TextSpan(text: '\nAll Categories ˅', style: TextStyle(fontSize: 11,color: Colors.purple)),
      
    ],
  ),
)
          ),
        ),
      ),
      body: Row(
        children: [
          Column(
            key:colKey,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: SizeConfig.screenHeight-AppBar().preferredSize.height,
                  color: AppColors.whiteColor,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:
                          categoryItemsDemo.asMap().entries.map<Widget>((e) {
                        int index = e.key;
                        CategoryItem categoryItem = e.value;
                        return GestureDetector(
                          onTap: () {
                            onCategoryItemClicked(context, categoryItem);
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
          Column(
            children: [
              Container(
                height: SizeConfig.screenHeight-AppBar().preferredSize.height,
                width: SizeConfig.screenWidth-120,
                child: StaggeredGridView.count(
                  crossAxisCount: 2,
     
                  children: beverages.asMap().entries.map<Widget>((e) {
                  
                    GroceryItem groceryItem = e.value;
                    return GestureDetector(
                      onTap: () {
                        onItemClicked(context, groceryItem);
                      },
                      child: Container(
                          //  margin: EdgeInsets.symmetric(vertical: 4),
                height: getProportionateScreenHeight(210),
                         padding: EdgeInsets.symmetric(horizontal: 0),
                        child: GroceryItemCardWidget(
                          item: groceryItem,
                        ),
                      ),
                    );
                  }).toList(),
                  staggeredTiles:
                      beverages.map<StaggeredTile>((_) => StaggeredTile.fit(1)).toList(),
                  mainAxisSpacing: 3.0,
                  crossAxisSpacing: 0.0, // add some space
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onItemClicked(BuildContext context, GroceryItem groceryItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(groceryItem)),
    );
  }
}
