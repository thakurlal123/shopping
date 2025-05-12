import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';

Future<void> placeOrder({
  required BuildContext context,
  required String customerPhone,
  required String customerName,
  required String cutomerAddress,
  String? customerDeviceToken
}) async {
final user = FirebaseAuth.instance.currentUser;
if(user!=null){
  try{
QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('cart').doc(user!.uid).collection('cartOrder').get();

  }catch(e){
    print("Error $e");
  }
}
}