import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/colors.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/const/list.dart';
import 'package:e_commerce_app/controller/auth_controller.dart';
import 'package:e_commerce_app/controller/profile_controller.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/view/auth_view/login_screen.dart';
import 'package:e_commerce_app/view/cart/component/detail_cart.dart';
import 'package:e_commerce_app/view/chat_screens/Messages_screen.dart';
import 'package:e_commerce_app/view/order_screens/order_screen.dart';
import 'package:e_commerce_app/view/profile/profile_edit_screen.dart';
import 'package:e_commerce_app/view/wishlist_screen/wishlist_screen.dart';
import 'package:e_commerce_app/widget_common/bg_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../const/images.dart';
import '../../const/styles.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProfileController());

    return bgWidget(
        backgroundImage: imgBackground,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body:StreamBuilder(
              stream: FireStoreServices.getUser(currentUser!.uid),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
             if(!snapshot.hasData)
               {
                 return CircularProgressIndicator();
               }
             else
               {
                 print("saleem-----------/${snapshot.data!.docs[0]}");
                 var data = snapshot.data!.docs[0];
                 return Column(
                   children: [
                     20.heightBox,
                     Align(

                         alignment: Alignment.topRight,
                         child: InkWell(
                           onTap: (){
                             Get.to(()=> EditProfileScreen(data: data,));
                             controller.nameController.text=data["name"];

                           },
                           child: Icon(
                             Icons.edit,
                             color: whiteColor,
                           ),
                         )),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(children: [
                         data["imageUrl"]=="" ? CircleAvatar(
                           radius: 42.0,
                           backgroundImage: AssetImage(
                             imgProfile2,
                           ),
                         ):
                         CircleAvatar(
                           backgroundColor: redColor,
                           radius: 42.0,
                           backgroundImage: Image.network(
                             data["imageUrl"],
                           ).image,
                         ),
                         const SizedBox(
                           width: 5,
                         ),
                          Expanded(
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                "${data["name"]}",
                                 style: TextStyle(
                                     color: whiteColor, fontFamily: semibold),
                               ),
                               Text(
                                 "${data["email"]}"
                                 ,
                                 style: TextStyle(color: whiteColor),
                               )
                             ],
                           ),
                         ),
                         OutlinedButton(
                           onPressed: () async{
                             await Get.put(AuthController()).signOutMethod(context);
                             Get.offAll((_)=> const LoginScreen());
                           },
                           style: OutlinedButton.styleFrom(
                               side: const BorderSide(color: whiteColor)),
                           child: const Text(
                             "LogOut",
                             style:
                             TextStyle(color: whiteColor, fontFamily: semibold),
                           ),
                         )
                       ]),
                     ),
                     const SizedBox(
                       height: 20,
                     ),
                     FutureBuilder(
                       future: FireStoreServices.getCounts(),
                       builder: (BuildContext context,AsyncSnapshot snapshot) {
                         if(!snapshot.hasData)
                           {
                             return Center(
                               child: CircularProgressIndicator(),
                             );
                           }
                         else{
                           var countData=snapshot.data;
                           return Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                               detailCart(
                                   title: "in your cart",
                                   width: context.screenWidth / 3.4,
                                   count: "${countData[0]}"),
                               detailCart(
                                   title: "in your wishlist",
                                   width: context.screenWidth / 3.4,
                                   count: "${countData[1]}"),
                               detailCart(
                                   title: " your orders",
                                   width: context.screenWidth / 3.4,
                                   count: "${countData[2]}"),
                             ],
                           );

                         }

                       }
                     ),
                     SizedBox(
                       height: 20,
                       child: Container(
                         color: redColor,
                       ),
                     ),
                     Container(
                       width: double.infinity,
                       height: 230,
                       color: redColor,

                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(

                           margin: EdgeInsets.all(4),
                           decoration: BoxDecoration(
                             color: whiteColor,
                             borderRadius: BorderRadius.circular(10),
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.5),
                                 spreadRadius: 2, // Spread radius
                                 blurRadius: 5, // Blur radius
                                 offset: Offset(0, 3),
                               ),
                             ],
                           ),
                           child: ListView.separated(
                               shrinkWrap: true,
                               itemBuilder: (context, index) {
                                 return ListTile(
                                   onTap: (){
                                     switch(index){
                                       case 0:
                                         Get.to(()=> const OrderScreen());
                                         break;
                                       case 1:
                                         Get.to(()=> const WishlistScreen());
                                         break;
                                       case 2:
                                         Get.to(()=> const MessagesScreen());
                                         break;
                                     }
                                   },
                                   leading: Image.asset(profileButtonIcon[index],width: 18,),
                                   title: Text(
                                     profileButtonList[index],
                                     style: TextStyle(
                                         color: darkFontGrey, fontFamily: semibold),
                                   ),
                                 );
                               },
                               separatorBuilder: (context, index) {
                                 return Divider(
                                   thickness: 3,
                                   color: lightGrey,
                                 );
                               },
                               itemCount: profileButtonIcon.length),
                         ),
                       ),
                     )
                   ],
                 );
               }
              },
            )
          ),
        ));
  }
}
