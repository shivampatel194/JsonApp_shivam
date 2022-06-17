import 'package:flutter/material.dart';
import 'package:test_fragment/config/Const.dart';
import 'package:test_fragment/config/colors.dart';

class CustomListtile extends StatelessWidget {
   final String title;
   final bool? isdense;
   final bool visualDense;
   final String image;
  const CustomListtile({Key? key, required this.title,this.isdense,required this.visualDense ,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(title,style: TextStyle(color: Appcolor().colorBlack,fontSize: 14),),
        dense: isdense ?? false,
        leading:  Container(height: 4.h ,width:6.w,child: Image.asset("${image}",color: Appcolor().maincolor,)),
        visualDensity: visualDense ? VisualDensity(horizontal: 0,vertical: 0) : null,
      ),
    );
  }
}
