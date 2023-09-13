import 'dart:io';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/controller/profile_controller.dart';
import 'package:e_commerce_app/widget_common/bg_widget.dart';
import 'package:e_commerce_app/widget_common/custom_button.dart';
import 'package:e_commerce_app/widget_common/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key,this.data});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProfileController());
    var authController=Get.put(AuthController());

    return bgWidget(backgroundImage: imgBackground,
    child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Obx(()=>Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 50,left: 12,right: 12),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5, // Spread radius
              blurRadius: 5, // Blur radius
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            data["imageUrl"]=="" && controller.imagePath.isEmpty ?CircleAvatar(
              radius: 42.0,
              backgroundImage: AssetImage(
                imgProfile2,
              ),
            )
                :data["imageUrl"]!=""&& controller.imagePath.isEmpty?  CircleAvatar(
              backgroundColor: redColor,
              radius: 42.0,
              backgroundImage: Image.network(
                data["imageUrl"],
              ).image,
            ):CircleAvatar(
                radius: 42.0,
                backgroundImage: Image.file(File(controller.imagePath.value)).image
            ),

            20.heightBox,
            ourButton(controller: null,title: "change", color:redColor,
              onPressed: (){
                controller.changeImage(context);
              }, textColor: whiteColor,),
            Divider(),
            20.heightBox,
            textField(title: "Name", controller: controller.nameController, hint: "Name"),
            10.heightBox,
            textField(title: "Old Password", controller: controller.oldPasswordController, hint: "Old Password",isSecure: true),
            10.heightBox,
            textField(title: "New Password", controller: controller.newPasswordController, hint: "New Password",isSecure: true),
            10.heightBox,
            SizedBox(
              width: context.screenWidth-60,
              child: ourButton(controller:authController,title: "Save", color: redColor,
                onPressed: ()async{

                // check if image is picked then upload it
                if(controller.imagePath.isNotEmpty)
                  {
                    await controller.uploadImage();

                  }else
                    {
                      controller.imagePathLink=data["imageUrl"];
                    }
                if(data["password"]==controller.oldPasswordController.text)
                  {
                   await controller.changeAuthPassword(email: data["email"],
                   password:controller.oldPasswordController.text,
                   newPassword: controller.newPasswordController.text,
                       );
                    await controller.updateProfile(
                        name: controller.nameController.text,
                        password: controller.newPasswordController.text,
                        imageUrl: controller.imagePathLink,

                    );
                  }else
                    {
                      VxToast.show(context, msg:"wrong password");
                    }




              },
                textColor: whiteColor,),
            )

          ],
        ),
      ),)

    )
    );
  }
}
