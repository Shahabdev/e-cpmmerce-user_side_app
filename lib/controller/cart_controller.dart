import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartController extends  GetxController
{
  var totalP=0.obs;
  var paymentIndex=0.obs;
  var placeOrder=false.obs;
  late dynamic productSnapshot;
  var productList=[];
  // shipping info textController
  var addressController=TextEditingController();
  var cityController=TextEditingController();
  var stateController=TextEditingController();
  var postalController=TextEditingController();
  var phoneController=TextEditingController();

   calculate(data)
   {
     totalP.value=0;
     for(int i=0;i<data.length;i++)
       {
         totalP.value=totalP.value+int.parse(data[i]['tPrice'].toString());
       }
   }
   changeIndex(index)
   {
     paymentIndex.value=index;
   }
   placeMyOrder({required paymentMethod,required totalAmount})
  async
  {
    placeOrder(true);
    await getProductDetails();
    await fireStore.collection(orderCollection).doc().set({
      "order_by":currentUser!.uid,
      "order_code":"233981237",
      "order_date":FieldValue.serverTimestamp(),
      "order_by_name":Get.find<HomeController>().username,
      "order_by_email":currentUser!.email,
      "order_by_address":addressController.text,
      "order_by_city":cityController.text,
      "order_by_state":stateController.text,
      "order_by_postalCode":postalController.text,
      "order_by_phone":phoneController.text,
      "payment_method":paymentMethod,
      "shipping_method":"Home delivery",
      "order_placed":true,
      "order_confirmed":false,
      "order_delivered":false,
      "order_on_delivery":false,
      "total_amount":totalAmount,
      "orders":FieldValue.arrayUnion(productList)
    });
    placeOrder(false);
  }

  getProductDetails()
  {
    for(var i=0;i < productSnapshot.length;i++)
      {
        productList.add({
          "color":productSnapshot[i]["color"],
          "img":productSnapshot[i]["img"],
          "tQuantity":productSnapshot[i]["tQuantity"],
          "title":productSnapshot[i]["title"],
          "vendor_id":productSnapshot[i]['vendor_id'],
          "tPrice":productSnapshot[i]['tPrice']
        });
      }

  }

  removeCart()
  async {
     for(var i=0;i< productSnapshot.length;i++)
       {
          await fireStore.collection(cartCollection).doc(productSnapshot[i].id).delete();
       }

  }
}