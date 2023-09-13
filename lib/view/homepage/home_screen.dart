import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/colors.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/const/list.dart';
import 'package:e_commerce_app/controller/auth_controller.dart';
import 'package:e_commerce_app/controller/home_controller.dart';
import 'package:e_commerce_app/controller/product-controller.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/view/auth_view/login_screen.dart';
import 'package:e_commerce_app/view/catagories/items_detail_screen.dart';
import 'package:e_commerce_app/view/homepage/search_screen.dart';
import 'package:e_commerce_app/widget_common/featured_button.dart';
import 'package:e_commerce_app/widget_common/home_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(AuthController());
    var prodController=Get.put(ProductController());
    var homeController=Get.find<HomeController>();
    return Container(
      height: context.screenHeight,
      width: context.screenWidth,
        color: lightGrey,
      padding: EdgeInsets.all(18),
      child: SafeArea(
        child:  Column(
            children: [

              Container(
                alignment: Alignment.center,
                height: 80,
                color: lightGrey,

                child: TextFormField(
                  controller: homeController.searchController,
                  decoration:  InputDecoration(
                    suffixIcon: InkWell(
                        onTap: (){
                          if(homeController.searchController.text.isNotEmptyAndNotNull)
                            {
                              Get.to(()=> SearchScreen(title: homeController.searchController.text));
                            }

                        },
                        child: Icon(Icons.search,color: redColor,)),
                    filled: true,
                    fillColor: whiteColor,
                    hintStyle: TextStyle(fontFamily: bold,color: textfieldGrey),
                    hintText: " Search any things"
                  ),

                ),
              ),
             Expanded(
               child: SingleChildScrollView(
                 physics: BouncingScrollPhysics(),
                 child: Column(
                   children: [
                     VxSwiper.builder(
                         aspectRatio: 16/9,
                         autoPlay: true,
                         height: 150,
                         enlargeCenterPage: true,
                         itemCount:sliderList.length , itemBuilder: (context,index)=>
                         Container(
                           margin: EdgeInsets.symmetric(horizontal: 8),
                           clipBehavior: Clip.antiAlias,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(15)
                           ),
                           child: Image.asset(sliderList[index],fit: BoxFit.fill,),

                         )),
                     SizedBox(height: 10,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children:
                       List.generate(2, (index) => homeButton(
                           title: index ==0 ? "Today's Deal":"Flash sale",
                           height: context.screenHeight * 0.13,
                           width:context.screenWidth/2.8,
                           icon: index==0 ? icTodaysDeal:icFlashDeal)),

                     ),
                     SizedBox(height: 10,),
                     VxSwiper.builder(
                         aspectRatio: 16/9,
                         autoPlay: true,
                         height: 150,
                         enlargeCenterPage: true,
                         itemCount:secondSliderList.length , itemBuilder: (context,index)=>
                         Container(
                           margin: EdgeInsets.symmetric(horizontal: 8),
                           clipBehavior: Clip.antiAlias,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(15)
                           ),
                           child: Image.asset(secondSliderList[index],fit: BoxFit.fill,),

                         )),
                     SizedBox(height: 10,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children:
                       List.generate(3, (index) => homeButton(
                           title: index ==0 ? "Top Categories":index==1 ?"Brand":"Top Seller",
                           height: context.screenHeight * 0.13,
                           width:context.screenWidth/3.5,
                           icon: index ==0 ? icTopCategories:index==1 ?icBrands:icTopSeller)),

                     ),
                     SizedBox(height: 10,),
                     Align(
                         alignment: Alignment.centerLeft,
                         child: Text("Featured Catogories",style: TextStyle(color: darkFontGrey,fontSize: 22,fontFamily: semibold),)),
                     SingleChildScrollView(
                       scrollDirection: Axis.horizontal,
                       child:  Row(
                         children: List.generate(3, (index) =>Column(
                       children: [
                         featureButton(title: featuredTitle1[index], icon: featuredImage1[index]),
                         SizedBox(height: 10,),
                         featureButton(title: featuredTitle2[index], icon:featuredImage2[index])
                       ],
                     )).toList(),
               )

                     ),
                        SizedBox(height: 10,),
                       Container(
                         width: double.infinity,
                         padding: EdgeInsets.all(12),
                           color: redColor,


                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("Featured Product",style: TextStyle(fontSize: 18,fontFamily: bold,color: whiteColor),),

                            SizedBox(height: 10,),
                             SingleChildScrollView(
                               scrollDirection: Axis.horizontal,
                               child: StreamBuilder(
                                 stream: FireStoreServices.getAllFeaturedProduct(),
                                 builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {

                                   if(!snapshot.hasData)
                                     {
                                       return Center(child: CircularProgressIndicator(),);
                                     }
                                   else if(snapshot.data!.docs.isEmpty)
                                     {
                                       return Center(child:
                                         Text("No Featured Products",
                                         style: TextStyle(color: darkFontGrey,fontFamily: (semibold)),),);
                                     }
                                   else
                                     {
                                       var featuredData=snapshot.data!.docs;
                                       return Row(
                                         children:  List.generate(
                                         featuredData.length,
                                          (index) => Container(

                                           decoration: BoxDecoration(

                                             borderRadius: BorderRadius.circular(10),
                                             color: whiteColor,
                                           ),
                                           margin: EdgeInsets.symmetric(horizontal: 4),
                                           padding: EdgeInsets.all(18),
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [

                                               Image.network("${featuredData[index]['p_imgs'][0]}",width: 150,height:130,fit: BoxFit.cover,),
                                               SizedBox(height: 10,),
                                               Text("${featuredData[index]['p_name']}",style: TextStyle(color: darkFontGrey,fontFamily: semibold),),
                                               SizedBox(height: 10,),
                                               Text("${featuredData[index]['p_price']}".numCurrency,style: TextStyle(color: redColor,fontFamily: bold),)

                                             ],
                                           ),
                                         )),
                                       );
                                     }




                                 }
                               ),
                             )
                           ],
                         ),
                       ),
                     SizedBox(height: 20,),
                     VxSwiper.builder(
                         aspectRatio: 16/9,
                         autoPlay: true,
                         height: 150,
                         enlargeCenterPage: true,
                         itemCount:sliderList.length , itemBuilder: (context,index)=>
                         Container(
                           margin: EdgeInsets.symmetric(horizontal: 8),
                           clipBehavior: Clip.antiAlias,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(15)
                           ),
                           child: Image.asset(sliderList[index],fit: BoxFit.fill,),

                         )),
                     SizedBox(height: 20,),
                     StreamBuilder(
                         stream: FireStoreServices.getAllProducts(),
                         builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                          if(!snapshot.hasData)
                            {
                              return Center(child:
                                CircularProgressIndicator(),);
                            }
                          else
                            {
                              var prodData=snapshot.data!.docs;
                              return GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: prodData.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,mainAxisExtent: 300,crossAxisSpacing: 10),
                                itemBuilder:(context,index)=>
                                    Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,  // Spread radius
                                              blurRadius: 3,    // Blur radius
                                              offset: Offset(0, 3), ),
                                          ],
                                          color: whiteColor,
                                          borderRadius: BorderRadius.circular(10)

                                      ),
                                      padding: EdgeInsets.all(12),
                                      child: InkWell(
                                        onTap: ()
                                        {
                                          Get.to(()=>  ItemsDetailsScreen(title:"${prodData[index]['p_name']}",data:prodData[index], ));
                                        },
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Image.network("${prodData[index]['p_imgs'][0]}",width: 200,fit: BoxFit.cover,height: 200,),
                                            SizedBox(height: 10,),
                                            Spacer(),
                                            Text("${prodData[index]['p_name']}",style: TextStyle(color: darkFontGrey,fontFamily: semibold),),
                                            SizedBox(height: 10,),

                                            Text("${prodData[index]['p_price']}",style: TextStyle(color: redColor,fontFamily: bold),)

                                          ],
                                        ),
                                      ),
                                    ));
                            }
                     })

                   ],
                 ),
               ),
             )
            ],
          ),
        ),
      );


  }
}
