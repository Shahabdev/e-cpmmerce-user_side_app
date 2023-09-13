import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widget_common/applogo_widget.dart';
import '../../widget_common/bg_widget.dart';
import '../../widget_common/custom_button.dart';
import '../../widget_common/custom_textfield.dart';
import '../homepage/home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var controller = Get.put(AuthController());


  // text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    final BuildContext currentContext = context;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: bgWidget(
        backgroundImage: "assets/icons/bg.png",
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              AppLogo(),
              SizedBox(
                height: 5,
              ),
              Text(
                "Login into eMart",
                style: TextStyle(
                    color: Colors.white, fontSize: 18, fontFamily: semibold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  width: context.screenWidth - 75,
                  height: 480,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        textField(
                            title: "Name",
                            hint: "Enter name",
                            controller: nameController),
                        textField(
                            title: email,
                            hint: hintEmail,
                            controller: emailController),
                        textField(
                            title: password,
                            hint: hintPassword,
                            controller: passwordController,
                            isSecure: true),
                        textField(
                            title: "Retype Password",
                            hint: hintPassword,
                            controller: rePasswordController,
                            isSecure: true),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Checkbox(
                                checkColor: redColor,
                                value: isCheck,
                                onChanged: (newValue) {
                                  setState(() {
                                    isCheck = newValue!;
                                  });
                                }),
                            Expanded(
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "I agreed to the ",
                                    style:
                                        TextStyle(color: fontGrey, fontSize: 18)),
                                TextSpan(
                                    text:
                                        "term &  conditions \n and privacy policy ",
                                    style:
                                        TextStyle(color: redColor, fontSize: 18)),
                              ])),
                            )
                          ],
                        ),
                        SizedBox(

                          height: 10,
                        ),

                        Container(
                          width: context.screenWidth - 2,
                          child: ourButton(


                              title: "Sign Up",
                              controller: controller,
                              color: isCheck == true ? redColor : lightGrey,
                              onPressed: () async{
                               controller.isLoading(true);
                                try {
                                  if (isCheck == true) {
                                    print("hamad correct ----------/$isCheck");
                                  await  controller
                                        .signupMethod(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            context: context)
                                        .then((value) {
                                      return controller.storeUserData(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }).then((value) {
                                      VxToast.show(context,
                                          msg: "signup successfully");

                                    });
                                   return  Get.offAll(() => Home());
                                  }
                                } catch (e) {
                                  controller.isLoading(false);
                                  print("hamad false ----------/$isCheck");
                                  auth.signOut();
                                  debugPrint("shahab-------------------/${e.toString()}");
                                  VxToast.show(context, msg: e.toString());
                                }
                              },
                              textColor: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(color: fontGrey, fontSize: 18)),
                            TextSpan(
                                text: "Login",
                                style: TextStyle(
                                    color: redColor,
                                    fontSize: 18,
                                    decoration: TextDecoration.underline)),
                          ])),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
