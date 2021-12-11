import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/screens/product_details/product_details_screen.dart';
import 'package:grocery_app/styles/colors.dart';

class GroceryItemCardWidget extends StatelessWidget {
  GroceryItemCardWidget({Key key, this.item}) : super(key: key);
  final GroceryItem item;

  final double width = 150;
  final double height = 250;
  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
       
         Padding(
           padding: const EdgeInsets.fromLTRB(1, 8, 8,0),
           child: GestureDetector(
             onTap:()=>
                 onItemClicked(context, item),
             child: Container(
                   width: width,
                   height: height,
                   decoration: BoxDecoration(
              border: Border.all(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
                   ),
                   child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: imageWidget(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: getProportionateScreenHeight(40),
                    child: AppText(
                      text: item.name,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: AppText(
                      text: item.description,
                      fontSize: 13,
                      // fontWeight: FontWeight.w600,
                      color: Color(0xFF7C7C7C),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      AppText(
                        text: "د.إ${item.price.toStringAsFixed(2)}",
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                     
                    ],
                  )
                ],
              ),
                   ),
                 ),
           ),
         ),
      Positioned(child: addWidget(),top:0,right:0),
      Padding(
        padding: const EdgeInsets.fromLTRB(1,8,0,0),
        child: Container(
        height: getProportionateScreenHeight(23),
        width: getProportionateScreenWidth(62),
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(6)),
        decoration: BoxDecoration(
          color: Colors.red[600].withOpacity(0.85),

            border: Border.all(
              color:  Colors.red[600].withOpacity(0.8),
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(borderRadius),bottomRight: Radius.circular(borderRadius))
          ),
        child: Text("40% OFF",softWrap:true,style:TextStyle(color: Colors.white,fontSize:12)),
        ),
      ),
      
       ] );
  }
 void onItemClicked(BuildContext context, GroceryItem groceryItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(groceryItem)),
    );
  }
  
  Widget imageWidget() {
    return Container(
// color: AppColors.whiteShader,
      child: Image.asset(item.imagePath,width:80,height:80),
    );
  }

  Widget addWidget() {
    return GestureDetector(
      onTap: () =>print("added"),
      child: Container(
        height: getProportionateScreenHeight(30),
        width:getProportionateScreenHeight(30),
        decoration: BoxDecoration(
          border: Border.all(  color: borderColor,),
            borderRadius: BorderRadius.circular(5),
            color: AppColors.primaryColor),
        child: Center(
          child: Icon(
            Icons.add,
            color: AppColors.whiteColor,
            size: 18,
          ),
        ),
      ),
    );
  }
}
