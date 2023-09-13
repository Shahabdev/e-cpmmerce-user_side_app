import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/view/order_screens/component/orderPlaceDetails.dart';
import 'package:e_commerce_app/view/order_screens/component/order_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import '../../const/colors.dart';

class OrderDetailScreen extends StatelessWidget {
  final dynamic data;
  const OrderDetailScreen({super.key,this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text("Order Details",style:TextStyle(color: redColor,) ,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(

            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   orderStatus(title: "Placed",color: redColor,icon: Icons.done,showDone: data['order_placed']),
                  orderStatus(title: "Confirmed",color: Colors.blue,icon: Icons.thumb_up,showDone: data['order_confirmed']),
                  orderStatus(title: "on Delivery",color: Colors.yellow,icon: Icons.car_crash,showDone: data['order_on_delivery']),
                  orderStatus(title: "Delivered",color: Colors.purple,icon: Icons.done_all,showDone: data['order_delivered']),
                ],
              ),
              Divider(thickness: 3,),
              5.heightBox,
            Container(

              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,  // Spread radius
                    blurRadius: 3,    // Blur radius
                    offset: Offset(0, 3), ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  orderPlaceDetails(title1: "Order Code", title2: "Shipping Method",
                      d1: data["order_code"],
                      d2: data["shipping_method"]),
                  orderPlaceDetails(title1: "Order Date",
                      title2: "Payment_Method",
                      d1:intl.DateFormat().add_yMd().format(data["order_date"].toDate()) ,
                      d2: data["payment_method"]),
                  orderPlaceDetails(title1: "Payment status",
                    title2: "Delivery Status",
                    d1: "Unpaid",
                    d2: "Order Delivered",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Shipping Address",style: TextStyle(color: darkFontGrey,fontFamily: (bold)),),
                            //Text("${data['order_by_name']}",),
                            Text("${data['order_by_email']}"),
                            Text("${data['order_by_address']}",),
                            Text("${data['order_by_city']}",),
                            Text("${data['order_by_state']}"),
                            Text("${data['order_by_phone']}"),
                            Text("${data['order_by_postalCode']}"),
                          ],
                        ),
                        Column(

                          children: [
                            Text("Total Amount",style: TextStyle(color: darkFontGrey,fontFamily: (bold)),),
                            Text("${data['total_amount']}",style: TextStyle(color: redColor,fontFamily: (bold)),),
                          ],
                        )
                      ],
                    ),
                  )

                ],
              ),
            ),
              Divider(),
              10.heightBox,
              Center(child: Text("ordered Product",style: TextStyle(color: darkFontGrey,fontFamily: (bold),fontSize: 18),)),
              10.heightBox,
              Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,  // Spread radius
                      blurRadius: 3,    // Blur radius
                      offset: Offset(0, 3), ),
                  ],
                ),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(

                      data['orders'].length,
                          (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          orderPlaceDetails(title1: "${data['orders'][index]['title']}",
                              title2:"${data['orders'][index]['tPrice']}",
                              d1: "${data['orders'][index]['tQuantity']}x",
                              d2: "Refundable"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(

                              width: 30,
                              height: 15,
                              color: Color(data['orders'][index]['color']),
                            ),
                          ),
                         const Divider()
                        ],
                      );
                          }).toList(),
                ),
              ),
              20.heightBox



            ],
          ),
        ),
      ),
    );
  }
}
