import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/common_widgets/drawer.dart';
import 'package:grocery_app/common_widgets/search_bar.dart';
import 'package:grocery_app/helpers/constants.dart';
import 'package:grocery_app/helpers/size_config.dart';
import 'package:grocery_app/styles/colors.dart';
import 'navigator_item.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;
  bool _searching = false;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    return Scaffold(
      key: _key,
       drawer: CategoryDrawer(),
      appBar: AppBar(
  //  automaticallyImplyLeading: false,
   actions: [  Padding(
     padding: const EdgeInsets.only(left:8.0),
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
   ),],
  leading: GestureDetector(
    onTap: (){
_key.currentState.openDrawer();
    },
    child: Row(
      children: [
       SizedBox(width: getProportionateScreenWidth(5)),
       IconButton(onPressed:null, icon: Image.asset("assets/icons/marketspalsh.png"),iconSize: 30,)
      
      ],
    ),
  ),
  titleSpacing: 0,
  title:
  
  _searching
              ? SearchBar(
                  isSearching: _searching,
                )
  :Row(children: [SvgPicture.asset("assets/icons/app_bar_lead.svg"),
    //  SizedBox(width: getProportionateScreenWidth(40)),
    Spacer(),
     Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.end,
       children: [
         Text("Location",style: TextStyle(color: AppColors.primaryColor,fontSize: 15)),
         
         Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Icon(Icons.location_on),
             Text("Brooklyn Home",style: TextStyle(color: AppColors.blackColor,fontSize: 15)),
           ],
         ),
       ],
     ),
     
     ],),
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
    );
  }

  BottomNavigationBarItem getNavigationBarItem(
      {String label, String iconPath, int index}) {
    Color iconColor =
        index == currentIndex ? AppColors.primaryColor : Colors.black;
    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(
        iconPath,
        color: iconColor,
      ),
    );
  }
}

