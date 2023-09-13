import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/colors.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WishLists",style:
        TextStyle(color: darkFontGrey,fontFamily: (semibold),fontSize: 18),),
      ),
      body: StreamBuilder(
          stream: FireStoreServices.getWishlist(),
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
                child:  const Text("No Order placed in wishlist! ",style:
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
                        child:  ListTile(
                          leading: Image.network('${data[index]['p_imgs'][0]}',width: 80,fit: BoxFit.cover,),
                          title: Text('${data[index]['p_name']} ',style: TextStyle(color: darkFontGrey,fontFamily: (semibold),fontSize: 16),),
                          subtitle: Text('${data[index]['p_price']}'.numCurrency,style: TextStyle(color: redColor,fontFamily: (semibold)),),
                          trailing: InkWell(
                              onTap: () async
                              {
                                await fireStore.collection(productCollection).doc(data[index].id).set(
                                  {
                                    "p_wishlist":FieldValue.arrayRemove([currentUser!.uid])
                                  },SetOptions(merge: true),
                                );
                              },
                              child: Icon(Icons.favorite,color: redColor,)),
                        ),
                      ),
                    );
                  });;
            }

          }),
    );
  }
}
