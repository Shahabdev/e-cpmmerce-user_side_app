import 'package:e_commerce_app/const/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
{
  @override
  void onInit() {
    getUserName();
    // TODO: implement onInit
    super.onInit();
  }
  var searchController=TextEditingController();
  var currentNavIndex=0.obs;
  var username='';
  getUserName() async
  {
    var n= await fireStore.collection(userCollection).where('id',isEqualTo: currentUser!.uid).get().then((value)
    {
      if(value.docs.isNotEmpty)
        {
         return value.docs.single['name'];
        }
    });
    username=n;
    print(username);
  }
}