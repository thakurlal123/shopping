import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoping/utils/AppConstant.dart';

import '../auth-ui/welcome-screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColour,
        title: Center(child: Text(AppConstant.appMainName)),
        actions: [
          GestureDetector(
              onTap: ()async{
                GoogleSignIn googleSignIn = GoogleSignIn();
                FirebaseAuth _auth = FirebaseAuth.instance;
                await _auth.signOut();
              await  googleSignIn.signOut();
                Get.offAll(()=>WecomeScreen());
              },
              child: Icon(Icons.logout))],
      ),
    );
  }
}
