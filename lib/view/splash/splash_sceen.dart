import 'package:e_commerce_app/const/colors.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/view/auth_view/login_screen.dart';
import 'package:e_commerce_app/view/homepage/home.dart';
import 'package:e_commerce_app/widget_common/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen()
  {
    Future.delayed(Duration(seconds: 3),()
    {
     auth.authStateChanges().listen((User?  user) {
       if(user == null && mounted)
         {
           Get.to(()=> LoginScreen());
         }
       else
         {
           Get.to(()=> Home());
         }
     });

    });
  }
  @override
  void initState() {
    changeScreen();
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(flex: 1, child: SizedBox(height: 50)),
            Expanded(
              child: Column(
                children: [
                  Center(child: AppLogo()),
                  const SizedBox(
                    height: 10,
                  ),
                 const  Text(
                    appname,
                    style: TextStyle(
                        color: Colors.white, fontFamily: bold, fontSize: 22),
                  ),
                ],
              ),
            ),
           const  SizedBox(
              height: 100,
            ),
           const  Text(
              appversion,
              style: TextStyle(color: Colors.white, fontFamily: semibold),
            ),
          const   SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
