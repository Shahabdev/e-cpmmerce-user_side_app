import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/colors.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/view/order_screens/order_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("My Orders",style:
        TextStyle(color: darkFontGrey,fontFamily: (semibold),fontSize: 18),),
      ),
      body: StreamBuilder(
          stream: FireStoreServices.getMyOrders(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapShot){
            if(!snapShot.hasData)
              {
                return const Center(
                  child:CircularProgressIndicator()
                  ,);
              }
            else if(snapShot.data!.docs.isEmpty)
              {
                return Center(
                  child:  const Text("No Order place yet! ",style:
                  TextStyle(color: darkFontGrey,fontFamily: (semibold),fontSize: 18),),
                );
              }
            else{
              var data=snapShot.data!.docs;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: lightGolden,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,  // Spread radius
                          blurRadius: 3,    // Blur radius
                          offset: Offset(0, 3), ),
                      ],
                    ),

                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: ListTile(
                      onTap: ()
                      {
                        Get.to(()=> OrderDetailScreen(data: data[index],));
                      },
                      tileColor: lightGolden,
                      leading:Text("(${index+1})".toString(),
                        style: TextStyle(color: darkFontGrey,fontFamily: (semibold)),),
                      title: Text(data[index]["order_code"].toString(),
                        style: TextStyle(color: darkFontGrey,fontFamily: (semibold)),),
                      subtitle: Text(data[index]["total_amount"].toString(),
                        style: TextStyle(color: redColor,fontFamily: (bold)),),
                      trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios,color: darkFontGrey,)),
                    ),
                  ),
                );
              });
            }

      }),
    );
  }
}
