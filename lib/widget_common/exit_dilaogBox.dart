 import 'package:e_commerce_app/const/colors.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/widget_common/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../const/styles.dart';

Widget exitDialog(context)
{
  return Dialog(
    child:  Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Confirm",style: TextStyle(color:darkFontGrey,fontSize: 18,fontFamily:(semibold)),),
          const Divider(),
          Text("Are you sure Your want to exit?"
              ,style: TextStyle(color:darkFontGrey,fontSize: 16,)),
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ourButton(title: "Yes", color: redColor, onPressed: (){
                SystemNavigator.pop();
              }, textColor: whiteColor),
              ourButton(title: "No", color: redColor, onPressed: (){
                Navigator.pop(context);
              }, textColor: whiteColor)
            ],
          )

        ],
      ),
    ),
  );
}