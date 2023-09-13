import 'package:e_commerce_app/const/colors.dart';
import 'package:flutter/cupertino.dart';

import '../../../const/styles.dart';

Widget detailCart({required String title,required width,required String count})
{
  return Container(
    height: 65,
    width: width,
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(10)
    ),
    padding: EdgeInsets.all(8),
    child: Column(
      
      children: [
        Text(count,style: TextStyle(color: darkFontGrey,fontFamily: bold,fontSize: 16),),
        SizedBox(height: 5,),
        Text(title,style: TextStyle(color: darkFontGrey),),
      ],
    ),
  );
}