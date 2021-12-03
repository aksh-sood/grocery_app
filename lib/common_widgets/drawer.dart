import 'package:flutter/material.dart';
import 'package:grocery_app/styles/colors.dart';

class CategoryDrawer extends StatelessWidget {
  const CategoryDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
       child: ListView(
       // Important: Remove any padding from the ListView.
       padding: EdgeInsets.zero,
       children: [
         const DrawerHeader(
           decoration: BoxDecoration(
             color: Colors.blue,
           ),
           child: Text('Drawer Header'),
         ),
         ListTile(
           title: const Text('Item 1'),
           onTap: () {
             // Update the state of the app
             // ...
             // Then close the drawer
             Navigator.pop(context);
           },
         ),
         ListTile(
           title: const Text('Item 2'),
           onTap: () {
             // Update the state of the app
             // ...
             // Then close the drawer
             Navigator.pop(context);
           },
         ),
       ],
     ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:   Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.end,
       children: [
         
         Text("Location",style: TextStyle(color: AppColors.blackColor,fontSize: 15)),
       ],
     ),
    );
  }
}