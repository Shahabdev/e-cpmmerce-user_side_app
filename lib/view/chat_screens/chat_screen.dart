import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/colors.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/controller/chat_controller.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/view/chat_screens/component/sender_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ChatController());
    return Scaffold(
      appBar: AppBar(
        title: Text("${controller.friendName}",style: TextStyle(color: darkFontGrey),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: StreamBuilder(
              stream: FireStoreServices.getMessages(controller.chatDocId.toString()),

           builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData)
                  {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                else if(snapshot.data!.docs.isEmpty)
                  {
                    return Center(
                      child: Text("Send Message"),
                    );
                  }
                else
                  {
                    return ListView(
                      children: snapshot.data!.docs.mapIndexed((currentValue,index){
                        var data=snapshot.data!.docs[index];

                        return  Align(
                            alignment: data['uId']==currentUser!.uid ? Alignment.centerRight:Alignment.centerLeft,
                            child: senderBubble(data));
                      }).toList()
                    );
                  }

           },
            )),
            Container(
              height: 80,
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(child: TextFormField(
                    controller: controller.messageController,

                    decoration: InputDecoration(

                      hintText: "Type Message here",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfieldGrey,

                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfieldGrey,
                        ),
                      ),
                    ),
                  )),
                  IconButton(onPressed: (){
                    controller.sendMsg(controller.messageController.text);
                    controller.messageController.clear();
                  }, icon:Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
