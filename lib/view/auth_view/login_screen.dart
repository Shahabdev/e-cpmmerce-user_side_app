import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/controller/auth_controller.dart';
import 'package:e_commerce_app/view/auth_view/signup_screen.dart';
import 'package:e_commerce_app/view/homepage/home.dart';
import 'package:e_commerce_app/widget_common/applogo_widget.dart';
import 'package:e_commerce_app/widget_common/bg_widget.dart';
import 'package:e_commerce_app/widget_common/custom_button.dart';
import 'package:e_commerce_app/widget_common/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../const/list.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var emailController = TextEditingController();
    var controller=Get.put(AuthController());
    return bgWidget(
      backgroundImage: imgBackground,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child:
                Column(
                  children: [
                    SizedBox(height: 80,),
                    AppLogo(),
                    SizedBox(height: 5,),
                    Text("Login into eMart",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: semibold),),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 30),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        width: context.screenWidth - 75,
                        height: 470,

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(height: 5,),
                              textField(title: email,hint: hintEmail,controller: emailController),
                              textField(title: password,hint: hintPassword,controller:passwordController),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: TextButton(onPressed: (){}, child: Text("Forget Password?",style: TextStyle(color: Colors.blue,fontSize: 20,decoration: TextDecoration.underline),))),

                              Container(
                                width: context.screenWidth - 2,
                                child: ourButton( title: "Login",controller: null, color: redColor, onPressed:()async{
                                  controller.isLoading(true);
                                  await controller.loginMethod(
                                      email:emailController.text,
                                      password: passwordController.text,
                                      context: context).then((value)
                                  {
                                    if(value  != null)
                                    {
                                      VxToast.show(context, msg: "login successfully");
                                      return Get.offAll(() => Home());
                                    }
                                    else{
                                      controller.isLoading(false);
                                    }

                                  });

                                }, textColor: Colors.white),),
                              SizedBox(height: 10,),
                              Text( "Or create a New Account",style: TextStyle(color: fontGrey),),
                              SizedBox(height: 10,),
                              Container(
                                  width: context.screenWidth - 2,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: lightGolden,
                                          padding: EdgeInsets.all(12)
                                      ),
                                      onPressed:(){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                                      },
                                      child: Text("Sin Up",style: TextStyle(color: redColor,fontFamily: semibold,),)),
                                  // child: ourButton(controller: null,title: "Sign Up", color: lightGolden, onPressed: (){
                                  //
                                  //   Get.to(()=>SignUpScreen());
                                  // }, textColor: redColor)
                                ),

                              SizedBox(height: 10,),
                              Text("Log in with",style: TextStyle(color: fontGrey)),
                              SizedBox(height: 10,),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(3, (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: lightGrey,
                                      radius: 25,
                                      child: Image.asset(socialIconList[index],width: 30,)

                                      ,
                                    ),
                                  ))
                              )


                            ],
                          ),)
                        ),
                      ),

                  ],
                ),)

          ),
    );
  }
}
