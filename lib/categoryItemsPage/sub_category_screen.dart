import 'package:flutter/material.dart';
import 'package:grocery_app/styles/colors.dart';

class SubCategoryScreen extends StatefulWidget {
  SubCategoryScreen({Key key,@required this.subCat,@required this.preVal }) : super(key: key);
List<String>subCat;
String preVal;
  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  static String selVal; 
  GoBack(){
    Navigator.pop(context,selVal);
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(
          children: [
         
          
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
              //     height: MediaQuery.of(context).size.height/3,
              // width: MediaQuery.of(context).size.width/2,
              padding:EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/4),
                  color: AppColors.whiteColor,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:
                         [
Text("Categories",style:TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),

              ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      children: List.generate(widget.subCat.length, (index){
                        return CatTile(cat:widget.subCat[index],inVal:widget.preVal);
                      }),
                    ),
                         ]
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
  const CatTile({
    Key key,@required this.cat,@required this.inVal
  }) : super(key: key);
final String cat;
  final String inVal;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: ,
      child:Text(cat,style:TextStyle(color:cat==inVal?Colors.purple:Colors.black,fontSize:10))
    );
  }
}

