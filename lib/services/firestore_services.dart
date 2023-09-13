import 'package:e_commerce_app/const/consts.dart';

class FireStoreServices
{
 static  getUser(uid)
 {
   return  fireStore.collection(userCollection).where('id',isEqualTo: uid).snapshots();
 }

 // get products

static getProduct(category)
{
  return fireStore.collection(productCollection).where('p_category',isEqualTo: category).snapshots();
}

static getCartData(uid)
{
  return fireStore.collection(cartCollection).where("added_by",isEqualTo: uid).snapshots();
}

//delete doc from cart
 static deleteProduct(uid)
 {
   return fireStore.collection(cartCollection).doc(uid).delete();
 }
 
 // get messages
 static getMessages(docId)
 {
   return fireStore.collection(chatCollection).doc(docId).collection(messageCollection).
   orderBy("created_on",descending: false).snapshots();
 }
  static getMyOrders()
  {
    return fireStore.collection(orderCollection).where('order_by',isEqualTo:currentUser!.uid).snapshots();
  }
  static getWishlist()
  {
    return fireStore.collection(productCollection).where('p_wishlist',arrayContains:currentUser!.uid).snapshots();
  }
  static getSubCat(title)
  {
    return fireStore.collection(productCollection).where('p_subcategory',isEqualTo: title).snapshots();
  }
  static getAllMessages()
  {
     return fireStore.collection(chatCollection).where("fromId",isEqualTo: currentUser!.uid).snapshots();
  }
  static getCounts() async
  {
    var res= await Future.wait([
    fireStore.collection(cartCollection).where("added_by",isEqualTo: currentUser!.uid).get().then((value)
    {
      return value.docs.length;
    }),
      fireStore.collection(productCollection).where('p_wishlist',arrayContains:currentUser!.uid).get().then((value)
      {
        return value.docs.length;
      }),
      fireStore.collection(orderCollection).where('order_by',isEqualTo:currentUser!.uid).get().then((value)
      {
        return value.docs.length;
      }),
    ]);
    return res;

  }

  static getAllProducts()
  {
    return fireStore.collection(productCollection).snapshots();
  }

  static getAllFeaturedProduct()
  {
    return fireStore.collection(productCollection).where('is_featured',isEqualTo: true).snapshots();
  }
  static getSearchProduct(title)
  {
    return fireStore.collection(productCollection).get();
  }
}