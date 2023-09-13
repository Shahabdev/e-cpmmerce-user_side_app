import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/colors.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/view/catagories/items_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String title;
  const SearchScreen({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title",style: TextStyle(color: darkFontGrey,fontFamily: semibold),),
      ),
      body: FutureBuilder(
        future: FireStoreServices.getSearchProduct(title),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData)
            {
              return Center(child: 
                CircularProgressIndicator(),);
            }
          else if(snapshot.data!.docs.isEmpty){

              return Center(child:Text("No Product Founds",
                style: TextStyle(color: darkFontGrey,fontFamily: (semibold)),)); 
            }
          else
            {
              var data=snapshot.data!.docs;
              var filterData=data.where((element) =>
                  element['p_name'].toString()
                  .toLowerCase().contains(title)).toList();
              return GridView(
                padding:const  EdgeInsets.all(12),
                gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 8,
              crossAxisSpacing: 8,mainAxisExtent: 250),
              children: filterData.mapIndexed((currentValue, index) =>
                  InkWell(
                    onTap: (){
                      Get.to(()=>ItemsDetailsScreen(title: title,data: filterData[index],));
                    },
                    child: Container(

                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 4,
                            spreadRadius: 4,
                            offset: Offset(0,3)
                          )
                        ],

                        borderRadius: BorderRadius.circular(10),

                        color: whiteColor,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      padding: EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Image.network("${filterData[index]['p_imgs'][0]}",width: 150,height:130,fit: BoxFit.cover,),
                          SizedBox(height: 10,),
                          Text("${filterData[index]['p_name']}",style: TextStyle(color: darkFontGrey,fontFamily: semibold),),
                          SizedBox(height: 10,),
                          Text("${filterData[index]['p_price']}".numCurrency,style: TextStyle(color: redColor,fontFamily: bold),)

                        ],
                      ),
                    ),
                  )
              ).toList(),);
            }
          
        },
      ),
    );
  }
}
