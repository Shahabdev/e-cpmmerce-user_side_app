import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController
{

  @override
  void onInit() {
    getChatId();
    // TODO: implement onInit
    super.onInit();
  }
  var chat= fireStore.collection(chatCollection);
  var friendName=Get.arguments[0];
  var friendId=Get.arguments[1];

  var senderName=Get.find<HomeController>().username;
  var currentId=currentUser!.uid;

  var messageController=TextEditingController();

  dynamic chatDocId;

  getChatId()async
  {
   await chat.where('users',isEqualTo:{
     friendId:null,
     currentId:null
   } ).limit(1).get().then((QuerySnapshot snapshot)
   {
     if(snapshot.docs.isNotEmpty)
       {
         chatDocId=snapshot.docs.single.id;
       }
     else
       {
         chat.add({
           "created_on":null,
           'last_msg':'',
           'users':{friendId:null,currentId:null},
           'toId':'',
           'fromId':'',
           'friend_Name':friendName,
           'sender_name':senderName
         }).then((value)
         {
           chatDocId=value.id;
         });
       }
   });
  }

  sendMsg(String msg)async
  {
    if(msg.trim().isNotEmpty)
      {
        chat.doc(chatDocId).update({
          "created_on":FieldValue.serverTimestamp(),
          'last_msg':msg,
          'toId':friendId,
          'fromId':currentId

        });
        chat.doc(chatDocId).collection(messageCollection).doc().set({
          "created_on":FieldValue.serverTimestamp(),
          'msg':msg,
          'uId':currentId
        });
      }
  }
}