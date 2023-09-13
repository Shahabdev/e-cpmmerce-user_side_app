import 'package:e_commerce_app/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../const/styles.dart';

Widget orderStatus ({icon,title,showDone,color}){
return  ListTile(
  title: Divider(color: darkFontGrey,thickness: 1,),
  leading: Container(
   padding: EdgeInsets.all(4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: color,
        width: 3
      )
    ),
    child: Icon(icon,color: color,),
  ),
  trailing: SizedBox(
    height: 100,
    width: 120,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,

      children: [
        Text("$title",style:TextStyle(color:darkFontGrey,fontFamily: (bold)) ,),
        showDone ?  Icon(Icons.done,color: redColor,):Container()
      ],
    ),
  ),
);
}