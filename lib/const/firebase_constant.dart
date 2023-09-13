import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth=FirebaseAuth.instance;
FirebaseFirestore fireStore=FirebaseFirestore.instance;
User? currentUser=auth.currentUser;

// collection
const userCollection="users";
const productCollection="products";
const cartCollection='cart';
const messageCollection='messages';
const chatCollection='chats';
const orderCollection='orders';