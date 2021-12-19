import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/helpers/constants.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/category_item.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:grocery_app/widgets/category_item_card_widget.dart';
import 'package:grocery_app/widgets/search_bar_widget.dart';

import '../categoryItemsPage/category_items_screen.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({@required this.cat});
  List cat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          getHeader(),
          Expanded(
            child: getStaggeredGridView(context),
          ),
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

  Widget getStaggeredGridView(BuildContext context) {
    return StaggeredGridView.count(
      crossAxisCount: 3,
      children: cat.asMap().entries.map<Widget>((e) {
        int index = e.key;
        Cat categoryItem = e.value;
        return GestureDetector(
          onTap: () {
            onCategoryItemClicked(context, categoryItem, cat);
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
      staggeredTiles:
          cat.map<StaggeredTile>((_) => StaggeredTile.fit(1)).toList(),
      mainAxisSpacing: 3.0,
      crossAxisSpacing: 4.0, // add some space
    );
  }

  // void onCategoryItemClicked(BuildContext context, CategoryItem categoryItem) {
  //   Navigator.of(context).push(new MaterialPageRoute(
  //     builder: (BuildContext context) {
  //       return CategoryItemsScreen(disVal:categoryItem.name);
  //     },
  //   ));
  // }
}
