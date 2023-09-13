import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/colors.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Messages",style:
        TextStyle(color: darkFontGrey,fontFamily: (semibold),fontSize: 18),),
      ),
      body: StreamBuilder(
          stream: FireStoreServices.getAllMessages(),
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
              return Padding(padding: EdgeInsets.all(12.0),
              child: Column
                (
                children: [
                  Expanded(child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context,index){
                    return Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 4,
                            spreadRadius: 4,
                            offset: Offset(0,3)
                          ),
                        ]
                      ),
                      child: ListTile(
                        title:Text("${data[index]['friend_Name']}",style: TextStyle(
                          color: darkFontGrey,fontFamily: (semibold)
                        ),),
                        leading: CircleAvatar(
                            backgroundColor: redColor,
                            child: Icon(Icons.person,color: whiteColor,)),
                      ),
                    );
                  }))
                ],
              ),);
            }

          }),
    );
  }
}
