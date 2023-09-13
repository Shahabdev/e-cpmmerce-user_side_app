import 'package:e_commerce_app/const/colors.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/controller/cart_controller.dart';
import 'package:e_commerce_app/view/cart/payment_methids.dart';
import 'package:e_commerce_app/widget_common/custom_button.dart';
import 'package:e_commerce_app/widget_common/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ShippingDetailScreen extends StatelessWidget {
  const ShippingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<CartController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Shipping Info",style: TextStyle(
          color: darkFontGrey,fontSize: 16,
          fontFamily: (semibold)
        ),),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(title: 'Continue',
            color: redColor, onPressed: (){
          if(controller.addressController.text.length > 10 )
            {
              Get.to(() => const PaymentMethod());
            }
          else
            {
              VxToast.show(context, msg: 'please enter Correct Address',
              bgColor: Colors.teal);
            }
            },
            textColor: whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            textField(title: "Address",
                controller:controller.addressController,
                hint: "address"),
            textField(title: "City",
                controller:controller.cityController,
                hint: "City"),
            textField(title: "State",
                controller:controller.stateController,
                hint: "State"),
            textField(title: "Postal Code",
                controller:controller.postalController,
                hint: "Postal Code"),
            textField(title: "Phone",
                controller:controller.phoneController,
                hint: "Phone"),

          ],
        ),
      ),
    );
  }
}
