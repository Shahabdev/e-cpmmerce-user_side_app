import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../const/firebase_constant.dart';

class AuthController extends GetxController {

var isLoading=false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // login function

  Future<UserCredential?> loginMethod({  context,email, password}) async {

    UserCredential? userCredential;
    try {
     userCredential= await auth.signInWithEmailAndPassword(email:email , password: password);
    } catch (e) {

      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // signUp method

  Future<UserCredential?> signupMethod({ email, password, context}) async {
    UserCredential? userCredential;
    try {
     userCredential= await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    }on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // store user data

  storeUserData({ name,  email, password}) async
  {
    DocumentReference store = fireStore.collection(userCollection).doc(
        currentUser!.uid);

    store.set({
      "name": name,
      "email": email,
      "password": password,
      "imageUrl": "",
      "id":currentUser!.uid,
      "cart_list":"00",
      "wish_list":"00",
      "order_list":"00"
    });
  }

  // logout method
signOutMethod(context) async
  {
    try {
      await auth.signOut();
    } catch (e) {
       print("logout error ------------/${e.toString()}");
       VxToast.show(context, msg:e.toString());
    }
  }
}
