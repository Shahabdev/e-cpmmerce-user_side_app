import 'package:e_commerce_app/const/colors.dart';
import 'package:flutter/cupertino.dart';

import '../../../const/styles.dart';

Widget orderPlaceDetails({required title1,required title2,required d1,required d2})
{
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(title1,style: TextStyle(color: darkFontGrey,fontFamily: (bold)),),
            Text(d1,style: TextStyle(color: redColor,fontFamily: (semibold)),),

          ],
        ),
        Column(
          children: [
            Text(title2,style: TextStyle(color: darkFontGrey,fontFamily: (bold)),),
            Text(d2,style: TextStyle(color: darkFontGrey,fontFamily: (semibold)),),

          ],
        )
      ],
    ),
  );
}