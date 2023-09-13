import 'package:e_commerce_app/const/colors.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/styles.dart';

Widget textField({required String title,required controller,required String hint,isSecure=false})

{
  return  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title,style: TextStyle(color: redColor,fontFamily: bold,fontSize: 16),),
      TextFormField(
        controller: controller,
        obscureText: isSecure,
        decoration: InputDecoration(
          hintText: hint,
          isDense: true,
          hintStyle: TextStyle(
            color: textfieldGrey,
            fontFamily: semibold
          ),
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: redColor))
        ),

      ),
      SizedBox(height: 10,)
    ],
  );
}