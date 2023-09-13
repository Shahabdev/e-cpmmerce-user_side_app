import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/controller/product-controller.dart';
import 'package:e_commerce_app/widget_common/bg_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../services/firestore_services.dart';
import 'items_detail_screen.dart';

class CategoryDetail extends StatefulWidget {
  final String title;
  const CategoryDetail({super.key, required this.title});

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  var controller = Get.find<ProductController>();
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchSubCategory(widget.title);
  }
  switchSubCategory(title)
  {
    if(controller.subCat.contains(title))
      {
        productMethod=FireStoreServices.getSubCat(title);
      }
    else
      {
        productMethod=FireStoreServices.getProduct(title);
      }
  }
  dynamic productMethod;
  @override
  Widget build(BuildContext context) {

    return bgWidget(
        backgroundImage: imgBackground,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              toolbarHeight: 80.0,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(widget.title),
            ),
            body: Column(
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        controller.subCat.length,
                            (index) => InkWell(
                              onTap: ()
                              {
                                switchSubCategory("${controller.subCat[index]}");
                                setState(() {

                                });
                              },
                              child: Container(
                          height: 60,
                          width: 120,
                          margin:
                          EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius:
                                BorderRadius.circular(15)),
                          child: Center(
                              child: Text(
                                "${controller.subCat[index]}",
                                style: TextStyle(color: darkFontGrey),
                              ),
                          ),
                        ),
                            )),
                  ),
                ),
                20.heightBox,
                StreamBuilder(
                    stream: productMethod,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            "No product is available",
                            style: TextStyle(color: fontGrey, fontSize: 25),
                          ),
                        );
                      } else {
                        var data = snapshot.data!.docs;
                        return Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 250,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8),
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                controller.checkIf(data[index]);
                                Get.to(() => ItemsDetailsScreen(
                                      title: "${data[index]["p_name"]}",
                                      data: data[index],
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2, // Spread radius
                                        blurRadius: 3, // Blur radius
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10)),
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      "${data[index]["p_imgs"][0]}",
                                      width: 200,
                                      fit: BoxFit.cover,
                                      height: 150,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${data[index]["p_name"]}",
                                      style: TextStyle(
                                          color: darkFontGrey,
                                          fontFamily: semibold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      " ${data[index]["p_price"]}".numCurrency,
                                      style: TextStyle(
                                          color: redColor, fontFamily: bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ));
                      }
                    }),
              ],
            )));
  }
}
