import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/const/list.dart';
import 'package:e_commerce_app/controller/cart_controller.dart';
import 'package:e_commerce_app/view/homepage/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../const/colors.dart';
import '../../const/styles.dart';
import '../../widget_common/custom_button.dart';
import '../homepage/home.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<CartController>();
    return Obx(()=>
       Scaffold(
        appBar: AppBar(
          title: Text(
            "Choose Payment Method",
            style: TextStyle(
                color: darkFontGrey, fontSize: 16, fontFamily: (semibold)),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child:controller.placeOrder.value ? Center(child: CircularProgressIndicator(),)
              : ourButton(
              title: 'Place My Order',
              color: redColor,
              onPressed: () {
                controller.placeMyOrder(paymentMethod:paymentNameList[controller.paymentIndex.value],totalAmount: controller.totalP.value);

                controller.removeCart();
                VxToast.show(context, msg: 'order placed',
                bgColor: Colors.blueAccent);
                 Get.offAll(Home());
                },
              textColor: whiteColor),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(()=>
             Column(
              children: List.generate(paymentImgList.length, (index) {
                return InkWell(
                  onTap: ()
                  {
                  controller.changeIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(

                        border: Border.all(color:
                        controller.paymentIndex.value ==index ? redColor:Colors.transparent,
                            width: 3),
                        borderRadius: BorderRadius.circular(14)),
                    margin: EdgeInsets.only(bottom: 8),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(
                          paymentImgList[index],
                          color:controller.paymentIndex.value ==index ? Colors.black.withOpacity(0.5):Colors.transparent ,
                          colorBlendMode:  controller.paymentIndex.value ==index ? BlendMode.darken:BlendMode.color,
                          width: double.infinity,
                          height: 130,
                          fit: BoxFit.cover,
                        ),
                        controller.paymentIndex.value ==index ?   Transform.scale(
                          scale: 1.4,
                          child: Checkbox(
                            activeColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              value: true,
                              onChanged: (value) {}),
                        ):Container(),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Text("${paymentNameList[index]}",
                          style: TextStyle(color: whiteColor,fontFamily: (semibold),
                          fontSize: 16),),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
