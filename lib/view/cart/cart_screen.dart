import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/colors.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/controller/cart_controller.dart';
import 'package:e_commerce_app/view/cart/shipping_detail.dart';
import 'package:e_commerce_app/widget_common/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../const/styles.dart';
import '../../services/firestore_services.dart';

class CartScreen extends StatelessWidget {
   CartScreen({super.key});
 var controller=Get.put(CartController());
  @override
  Widget build(BuildContext context) {
  
    return SafeArea(
      child: Scaffold(
       backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Shopping Cart",style: TextStyle(color: darkFontGrey),),
        ),
        bottomNavigationBar:    SizedBox(
         height: 60,
          child: ourButton(title: "Proceed to Shipping",
              color: redColor,
              onPressed: (){
                Get.to(()=> const ShippingDetailScreen());

              },
              textColor: whiteColor),
        ),
        body: StreamBuilder(
          stream: FireStoreServices.getCartData(currentUser!.uid),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
          {
             if(!snapshot.hasData)
              {
                return Center(child: CircularProgressIndicator(color: darkFontGrey,),) ;
              }
             else if(snapshot.data!.docs.isEmpty)
               {
                 return Center(child: Text("No data Found in Cart",
                 style: TextStyle(color: darkFontGrey,fontSize: 25),),);
               }
             else
               {
                 var data =snapshot.data!.docs;
                 controller.calculate(data);
                 controller.productSnapshot=data;
                 return Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                     children: [
                       Expanded(child: ListView.builder(
                           itemCount: data.length,
                           itemBuilder: (context,index){
                         return Column(
                           children: [
                             8.heightBox,
                             Container(
                               color: lightGolden,

                               child: ListTile(
                                 leading: Image.network('${data[index]['img']}',width: 80,fit: BoxFit.cover,),
                                 title: Text('${data[index]['title']} (x${data[index]['tQuantity']})',style: TextStyle(color: darkFontGrey,fontFamily: (semibold),fontSize: 16),),
                                 subtitle: Text('${data[index]['tPrice']}'.numCurrency,style: TextStyle(color: redColor,fontFamily: (semibold)),),
                                 trailing: InkWell(
                                     onTap: ()
                                     {
                                       FireStoreServices.deleteProduct(data[index].id);
                                     },
                                     child: Icon(Icons.delete)),
                               ),
                             ),
                           ],
                         );
                       })),
                       5.heightBox,
                       Container(
                         padding: EdgeInsets.all(12),
                         width: context.screenWidth - 60,
                         decoration: BoxDecoration(
                             color: lightGolden,
                             borderRadius: BorderRadius.circular(10)
                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text("Total Price",style: TextStyle(fontFamily: (semibold),color: darkFontGrey),),
                             Obx(
                               ()=> Text("${controller.totalP.value}".numCurrency,style: TextStyle(fontFamily: (semibold),color: redColor),)),
                           ],
                         ),
                       ),
                       10.heightBox,
                       // SizedBox(
                       //   width: context.screenWidth -60,
                       //   child: ourButton(title: "Proceed to Shipping",
                       //       color: redColor,
                       //       onPressed: (){
                       //     Get.to(()=> const ShippingDetailScreen());
                       //
                       //       },
                       //       textColor: whiteColor),
                       // )


                     ],
                   ),
                 );
               }
          },
        )      ),
    );
  }
}
