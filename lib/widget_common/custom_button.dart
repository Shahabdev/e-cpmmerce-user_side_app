
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../const/colors.dart';
import '../const/styles.dart';
import '../controller/auth_controller.dart';

Widget ourButton({required String title,required color,required onPressed,required textColor,AuthController? controller})
{

 return ElevatedButton(
   style: ElevatedButton.styleFrom(
     backgroundColor: color,
     padding: EdgeInsets.all(12)
   ),
   onPressed:onPressed,
 child:controller != null ? Obx(()=>controller.isLoading.value
     ?
 CircularProgressIndicator(color: whiteColor,strokeWidth: 3,)
     : Text(title,style: TextStyle(color: textColor,fontFamily: bold),
 ) ) : Text(title,style: TextStyle(color: textColor,fontFamily: bold),
 ),
             );
}