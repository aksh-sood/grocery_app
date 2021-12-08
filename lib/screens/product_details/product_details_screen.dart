import 'dart:ui';
import 'package:accordion/accordion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:grocery_app/widgets/item_counter_widget.dart';

import 'favourite_toggle_icon_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final GroceryItem groceryItem;

  const ProductDetailsScreen(this.groceryItem);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int amount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,foregroundColor: Colors.transparent,),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              getImageHeaderWidget(),
              Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      widget.groceryItem.name,
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    subtitle: AppText(
                      text: widget.groceryItem.description,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.greyShader,
                    ),
                    trailing: FavoriteToggleIcon(),
                  ),
                  // Spacer(),
                  
                  // Spacer(),
                  // Divider(thickness: 1),
                  getProductDataRowWidget("Product Details"),
                  // Divider(thickness: 1),
                  // getProductDataRowWidget("Nutritions",
                      // customWidget: nutritionWidget()),
                  // Divider(thickness: 1),
                  // getProductDataRowWidget(
                    // "Review",
                    // customWidget: ratingWidget(),
                  // ),
                  // Spacer(),
                  
                
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageHeaderWidget() {
    return Container(
      height: 250,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF3366FF).withOpacity(0.1),
              const Color(0xFF3366FF).withOpacity(0.09),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Image(
        image: AssetImage(widget.groceryItem.imagePath),
      ),
    );
  }

  Widget getProductDataRowWidget(String label, {Widget customWidget}) {
    return Accordion(
	maxOpenSections: 2,
	// headerTextStyle: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
	// leftIcon: Icon(Icons.audiotrack, color: Colors.white),
  headerBackgroundColor: AppColors.whiteColor,
	children: [
		AccordionSection(
			isOpen: true,
			header: Text("intro",style:TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
			content: Text('This is the introduction right here ...'),
		),
		AccordionSection(
			isOpen: true,
			header: Text('About Us',style: TextStyle(color: Colors.white, fontSize: 17)),
			content: Icon(Icons.airline_seat_flat, size: 120, color: Colors.blue[200]),
		),
		AccordionSection(
			isOpen: true,
			header: Text('Company Info',style: TextStyle(color: Colors.white, fontSize: 17)),
			content: Icon(Icons.airplay, size: 70, color: Colors.green[200]),
		),
	],
);
  }

  Widget nutritionWidget() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text: "100gm",
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: Color(0xff7C7C7C),
      ),
    );
  }

  Widget ratingWidget() {
    Widget starIcon() {
      return Icon(
        Icons.star,
        color: Color(0xffF3603F),
        size: 20,
      );
    }

    return Row(
      children: [
        starIcon(),
        starIcon(),
        starIcon(),
        starIcon(),
        starIcon(),
      ],
    );
  }

  double getTotalPrice() {
    return amount * widget.groceryItem.price;
  }
}


  //  AppText(text: label, fontWeight: FontWeight.w600, fontSize: 16),
  //         Spacer(),
  //         if (customWidget != null) ...[
  //           customWidget,
  //           SizedBox(
  //             width: 20,
  //           )
  //         ],
  //         Icon(
  //           Icons.arrow_forward_ios,
  //           size: 20,
  //         )

// Row(
                      //   children: [
                      //      Text(
                      //       "د.إ${getTotalPrice().toStringAsFixed(2)}",
                      //       style: TextStyle(
                      //         fontSize: 24,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     Spacer(),
                      //     ItemCounterWidget(
                      //       onAmountChanged: (newAmount) {
                      //         setState(() {
                      //           amount = newAmount;
                      //         });
                      //       },
                      //     ),
                         
                         
                      //   ],
                      // ),

                      //   Spacer(),
                      // AppButton(
                      //   label: "Add To Basket",
                      // ),
                      // Spacer(),


                    //   Row(
                    //   children: [
                    //     AppText(text:"Price", fontWeight: FontWeight.w600, fontSize: 16),
                    //     Spacer(),
                    //     Text(
                    //       "د.إ${widget.groceryItem.price.toStringAsFixed(2)}",
                    //       style: TextStyle(
                    //         fontSize: 24,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     )
                    //   ],
                    // ),