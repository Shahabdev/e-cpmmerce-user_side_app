import 'package:e_commerce_app/const/colors.dart';
import 'package:e_commerce_app/controller/home_controller.dart';
import 'package:e_commerce_app/view/cart/cart_screen.dart';
import 'package:e_commerce_app/view/catagories/catagories_screen.dart';
import 'package:e_commerce_app/view/homepage/home_screen.dart';
import 'package:e_commerce_app/widget_common/exit_dilaogBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../const/images.dart';
import '../profile/profile_Screen.dart';

class Home extends StatelessWidget {
  Home({super.key});

  var controller = Get.put(HomeController());
  var navbarItems = [
    BottomNavigationBarItem(
        icon: Image.asset(
          icHome,
          width: 26,
        ),
        label: "Home"),
    BottomNavigationBarItem(
        icon: Image.asset(
          icCategories,
          width: 26,
        ),
        label: "Categories"),
    BottomNavigationBarItem(
        icon: Image.asset(
          icCart,
          width: 26,
        ),
        label: "Cart"),
    BottomNavigationBarItem(
        icon: Image.asset(
          icProfile,
          width: 26,
        ),
        label: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    var navbarBody = [
      HomeScreen(),
      CategoriesScreen(),
      CartScreen(),
      ProfileScreen()
    ];
    return WillPopScope(
      onWillPop: ()async {
         showDialog(
             barrierDismissible: false,
             context:context , builder: (context)
         => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
              children: [
                Obx(
            ()=> Expanded(
                      child: navbarBody.elementAt(controller.currentNavIndex.value)),
                )
              ],
            ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            backgroundColor: whiteColor,
            items: navbarItems,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: redColor,
            selectedLabelStyle: TextStyle(color: redColor),
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
