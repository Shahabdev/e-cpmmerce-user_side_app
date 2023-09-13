import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends  GetxController
{
  var quantity= 0.obs;
  var colorIndex=0.obs;
  var totalPrice=0.obs;
  var subCat=[];
  var isFav=false.obs;

  getSubCategories(title)
  async
  {
    subCat.clear();
    var data = await rootBundle.loadString("lib/services/catagories_model.json");
    var decode= categoryModelFromJson(data);
    var s=decode.categories.where((element) => element.name==title).toList();

    for(var e in s[0].subcategory)
      {
        subCat.add(e);
      }
  }
  changeColorIndex(index)
  {
    colorIndex.value=index;
  }
  increaseQuantity()
  {
    if(quantity.value < 20)
      {
        quantity.value++;
      }

  }
  decreaseQuantity()
  {
    if(quantity.value > 0)
    {
      quantity.value--;

    }

  }

  calculateTotalPrice(price)
  {
    totalPrice.value= price * quantity.value;
  }

  addToCart({title,seller,tPrice,tQuantity,color,img,context,vendorID}) async
  {
  await  fireStore.collection(cartCollection).doc().set({
      "title":title,
      "seller":seller,
      "tPrice":tPrice,
      "tQuantity":tQuantity,
      "img":img,
      "color":color,
      "vendor_id":vendorID,
    "added_by":currentUser!.uid
    }).onError((error, stackTrace) {
      VxToast.show(context, msg: error.toString());
  });
  }
  resetValues()
  {
    quantity.value=0;
    totalPrice.value=0;
    colorIndex.value=0;
  }

  addToWishlist(uid,context) async
  {
    await fireStore.collection(productCollection).doc(uid).set({
      "p_wishlist":FieldValue.arrayUnion([currentUser!.uid])
    },SetOptions(merge:true));
    isFav(true);
    VxToast.show(context, msg:'add to wishlist',
        bgColor:Vx.blue500);
  }

  removeFromWishlist(uid,context)async{
    await fireStore.collection(productCollection).doc(uid).set({
      "p_wishlist":FieldValue.arrayRemove([currentUser!.uid])
    },SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg:'remove from wishlist',
    bgColor:Vx.blue500);
  }

  checkIf(data){
    if(data['p_wishlist'].contains(currentUser!.uid))
      {
        isFav(true);
      }
    else
      {
        isFav(false);
      }
  }
}