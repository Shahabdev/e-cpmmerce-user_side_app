import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController
{
  var  isLoading=false.obs;
  var imagePathLink='';
  //edit textEditing Controller
  var nameController=TextEditingController();
  var oldPasswordController=TextEditingController();
  var newPasswordController=TextEditingController();
  var imagePath=''.obs;
  changeImage(context) async
  {

    try{
      final image= await ImagePicker().pickImage(source: ImageSource.camera);
      if(image==null)
        return "something went to wrong";
     imagePath.value=image.path;
    }on PlatformException catch(e)
    {
        VxToast.show(context, msg: e.toString());
    }
  }

  uploadImage()async{
    var fileName=basename(imagePath.value);
    var destination="images/${currentUser!.uid}/$fileName";
    Reference ref= FirebaseStorage.instance.ref(destination);
    await ref.putFile(File(imagePath.value));
    imagePathLink=await ref.getDownloadURL();
  }

  updateProfile({name,password,imageUrl})async{

    var store=fireStore.collection(userCollection).doc(currentUser!.uid);
    await store.set({
      "name":name,
      "password":password,
      "imageUrl":imageUrl
    },SetOptions(merge: true)
    );
    isLoading(false);
  }
  
  changeAuthPassword({email,password,newPassword,context}) async
  {
    final cred= EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword);
    }).onError((error, stackTrace) {
      VxToast.show(context, msg:"not change auth password");
    });
  }
}