import 'package:e_commerce_app/const/colors.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget homeButton({required String title,required height,required width,required icon})
{
  return Container(

    height: height,
    width: width,
    decoration: BoxDecoration
      (
        boxShadow: [
    BoxShadow(
    color: Colors.grey.withOpacity(0.5),
      spreadRadius: 2,  // Spread radius
      blurRadius: 3,    // Blur radius
      offset: Offset(0, 3), ),
      ],
      color: whiteColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(icon,width: 26,),
        SizedBox(height: 10,),
        Text(title,style: TextStyle(fontFamily: semibold,color: darkFontGrey),)
      ],
    ),
  );
}