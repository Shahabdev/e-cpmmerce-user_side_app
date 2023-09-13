import 'package:e_commerce_app/const/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget AppLogo()
{
  return Container(
    height: 80,
    width: 80,

    decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(19),
      color:Colors.white,
    ),
    child: Image.asset(icAppLogo,scale: 8,),
  );
}