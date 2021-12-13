import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/screens/product_details/product_details_screen.dart';
import 'package:grocery_app/styles/colors.dart';

class GroceryItemCardWidget extends StatelessWidget {
  GroceryItemCardWidget({Key key, this.item}) : super(key: key);
  final GroceryItem item;

  final double width = 150.w;
  final double height = 250.h;
  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18.r;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
       
         Container(
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
          padding:  EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 15.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: ()=>    onItemClicked(context, item),
                child: Expanded(
                  child: Center(
                    child: imageWidget(),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              GestureDetector(
                onTap: ()=> onItemClicked(context, item),
                child: Container(
                  height: getProportionateScreenHeight(40),
                  child: AppText(
                    text: item.name,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
                       GestureDetector(
                onTap: ()=> onItemClicked(context, item),
                child: Expanded(
                  child: AppText(
                    text: item.description,
                    fontSize: 13.sp,
                    // fontWeight: FontWeight.w600,
                    color: Color(0xFF7C7C7C),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: "د.إ${item.price.toStringAsFixed(2)}",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                 addWidget()
                ],
              )
            ],
          ),
               ),
             ),
      // Positioned(child: addWidget(),top:0,right:0),
      Container(
      height:23.h,
      width: 62.w,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        color: Colors.red[600].withOpacity(0.85),

          border: Border.all(
            color:  Colors.red[600].withOpacity(0.8),
          ),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(borderRadius),bottomRight: Radius.circular(borderRadius))
        ),
      child: Text("40% OFF",
      softWrap:false
      ,style:TextStyle(color: Colors.white,fontSize:12.sm)),
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
        height: 30.h,
        width:30.h,
        decoration: BoxDecoration(
          border: Border.all(  color: borderColor,),
            borderRadius: BorderRadius.circular(5.r),
            color: AppColors.primaryColor),
        child: Center(
          child: Icon(
            Icons.add,
            color: AppColors.whiteColor,
            size: 18.r,
          ),
        ),
      ),
    );
  }
}
