import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/colors.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/const/list.dart';
import 'package:e_commerce_app/controller/product-controller.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/view/catagories/categories-Details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widget_common/bg_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProductController());
    return bgWidget(
        backgroundImage: imgBackground,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            toolbarHeight: 80.0,
            title: Text(
              "Categories",
              style:
                  TextStyle(color: whiteColor, fontFamily: bold, fontSize: 22),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(15),
            child: GridView.builder(
                itemCount: 9,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 200,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8),
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2, // Spread radius
                        blurRadius: 3, // Blur radius
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(15),
                  child: InkWell(
                    onTap: (){
                      controller.getSubCategories(categoryTitle[index]);
                      Get.to(()=> CategoryDetail(title: categoryTitle[index]));
                    },
                    child: Column(
                      children: [
                        Image.asset(categoryImageList[index],width: 200,height: 120,fit: BoxFit.cover,),
                        SizedBox(height: 10,),
                        Text(categoryTitle[index],style: TextStyle(fontFamily: semibold,color: darkFontGrey,),)
                      ],
                    ),
                  ),
                )),
          ),

        ));
  }
}
