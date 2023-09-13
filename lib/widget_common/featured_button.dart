 import 'package:e_commerce_app/const/colors.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/view/catagories/categories-Details.dart';
import 'package:e_commerce_app/view/catagories/items_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget featureButton({required String title,required icon})
{
 return InkWell(
   onTap: (){
     Get.to(()=> CategoryDetail(title: title));
   },
   child: Container(
    decoration: BoxDecoration(
      color: whiteColor,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,  // Spread radius
          blurRadius: 3,    // Blur radius
          offset: Offset(0, 3), ),
      ],
    ),
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.all(8),

      child: Row(
        children: [
          Image.asset(icon,width: 60,fit: BoxFit.fill,),
          SizedBox(width: 10,),
          Text(title,style: TextStyle(
            color: darkFontGrey,
            fontFamily: semibold,

          ),)
        ],
      ),
    ),
 );
}