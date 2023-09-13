import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/const/list.dart';
import 'package:e_commerce_app/view/chat_screens/chat_screen.dart';
import 'package:e_commerce_app/widget_common/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/product-controller.dart';
import '../../services/firestore_services.dart';

class ItemsDetailsScreen extends StatelessWidget {
  final String title;
  final dynamic data;
  const ItemsDetailsScreen({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async
      {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              controller.resetValues();
              Get.back();
            },
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            title,
            style: TextStyle(color: darkFontGrey),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.share)),
            Obx(()=>
               IconButton(onPressed: () {
                if(controller.isFav.value)
                  {
                    controller.removeFromWishlist(data.id,context);
                  }
                else{
                  controller.addToWishlist(data.id,context);
                }
              }, icon: Icon(Icons.favorite,
              color: controller.isFav.value ? redColor:darkFontGrey,)),
            )


          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                      autoPlay: true,
                      viewportFraction: 1.0,
                      height: 300,
                      aspectRatio: 16 / 9,
                      itemCount: data['p_imgs'].length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          child: Image.network(
                            data["p_imgs"][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          color: darkFontGrey, fontSize: 16, fontFamily: bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    VxRating(
                        isSelectable: false,
                        value: double.parse(data['p_rate']),
                        size: 25,
                        count: 5,
                        //stepInt: true,
                        selectionColor: golden,
                        normalColor: fontGrey,
                        maxRating: 5,
                        onRatingUpdate: (value) {}),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${data['p_price']}".numCurrency,
                      style: TextStyle(
                          color: redColor, fontSize: 22, fontFamily: bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: textfieldGrey,
                      height: 60,
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${data['p_seller']}",
                                  style: const TextStyle(
                                      color: whiteColor,
                                      fontSize: 22,
                                      fontFamily: semibold),
                                ),
                                Text(
                                  "In the House Brand",
                                  style: TextStyle(
                                      color: darkFontGrey,
                                      fontSize: 18,
                                      fontFamily: bold),
                                ),
                              ],
                            ),
                          )),
                          InkWell(
                            onTap: (){
                              Get.to(()=> const ChatScreen(),
                              arguments: [data['p_seller'],data['vendor_id']]);

                            },
                            child: CircleAvatar(
                              backgroundColor: whiteColor,
                              child: Icon(
                                Icons.message_outlined,
                                color: darkFontGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: whiteColor,
                      ),
                      padding: EdgeInsets.all(12),
                      child: Obx(
                        () => Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: 100,
                                      child: Text(
                                        "Color",
                                        style: TextStyle(color: textfieldGrey),
                                      )),
                                  Row(
                                      children: List.generate(
                                    data['p_colors'].length,
                                    (index) => Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        InkWell(
                                          onTap: (() {
                                            controller.changeColorIndex(index);
                                          }),
                                          child: VxBox()
                                              .size(40, 40)
                                              .color(
                                                  Color(data['p_colors'][index])
                                                      .withOpacity(1.0))
                                              .roundedFull
                                              .margin(EdgeInsets.symmetric(
                                                  horizontal: 4))
                                              .make(),
                                        ),
                                        Visibility(
                                            visible: index == controller.colorIndex.value,
                                            child: Icon(
                                              Icons.done,
                                              color: Colors.white,
                                            ))
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  const Row(
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          child: Text(
                                            "Quantity",
                                            style:
                                                TextStyle(color: textfieldGrey),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(children: [
                                    IconButton(
                                        onPressed: () {

                                          controller.decreaseQuantity();
                                          controller.calculateTotalPrice(data["p_price"]);
                                        },
                                        icon: Icon(Icons.remove)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                   controller.quantity.value.text.size(16).fontFamily(bold).color(darkFontGrey).make(),
                                    IconButton(
                                        onPressed: () {

                                          controller.increaseQuantity();
                                          controller.calculateTotalPrice(data["p_price"]);
                                        }, icon: Icon(Icons.add)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "(${data['p_quantity']} available)",
                                      style: TextStyle(
                                          color: textfieldGrey,
                                          fontFamily: bold,
                                          fontSize: 16),
                                    ),
                                  ])
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const Row(
                                  children: [
                                    SizedBox(
                                        width: 100,
                                        child: Text(
                                          "Total",
                                          style: TextStyle(color: textfieldGrey),
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Row(children: [
                                  Text(
                                   "${controller.totalPrice.value}".numCurrency,
                                    style: TextStyle(
                                        color: redColor, fontFamily: bold),
                                  )
                                ])
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                          color: darkFontGrey, fontFamily: bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${data['p_desc']}",
                      style: TextStyle(
                          color: darkFontGrey,
                          fontFamily: semibold,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          itemsDetailButtonList.length,
                          (index) => Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2, // Spread radius
                                      blurRadius: 5, // Blur radius
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  color: whiteColor,
                                ),
                                margin: EdgeInsets.symmetric(vertical: 4),
                                child: ListTile(
                                  title: Text(
                                    itemsDetailButtonList[index],
                                    style: TextStyle(
                                        color: darkFontGrey,
                                        fontFamily: semibold),
                                  ),
                                  trailing: Icon(Icons.arrow_forward_outlined),
                                ),
                              )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Product you may also like this",
                      style: TextStyle(
                          color: darkFontGrey,
                          fontFamily: semibold,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //i copied this from home screen of featured products
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            6,
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
                                      Image.asset(
                                        imgP1,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Laptop 8Gb/256GB",
                                        style: TextStyle(
                                            color: darkFontGrey,
                                            fontFamily: semibold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "\$600",
                                        style: TextStyle(
                                            color: redColor, fontFamily: bold),
                                      )
                                    ],
                                  ),
                                )),
                      ),
                    )
                  ],
                ),
              ),
            )),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ourButton(
                  title: "add to cart",
                  color: redColor,
                  onPressed: () {
                    controller.addToCart(
                      vendorID: data['vendor_id'],
                      seller: data["p_seller"],
                      title: data["p_name"],
                      context: context,
                      img:data["p_imgs"][0],
                      color: data["p_colors"][controller.colorIndex.value],
                      tPrice: controller.totalPrice.value,
                      tQuantity: controller.quantity.value
                    );
                    VxToast.show(context, msg: "added to cart");
                  },
                  textColor: whiteColor),
            )
          ],
        ),
      ),
    );
  }
}
