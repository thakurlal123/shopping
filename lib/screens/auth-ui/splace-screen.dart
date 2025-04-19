import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:shoping/controllers/get-user-data-controller.dart';
import 'package:shoping/screens/admin-panel/admin-main-screen.dart';
import 'package:shoping/screens/auth-ui/welcome-screen.dart';
import 'package:shoping/screens/user-panel/main-screen.dart';
import 'package:shoping/utils/AppConstant.dart';

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({super.key});

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {

  User? user= FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    Timer(Duration(seconds: 3), (){
      //Get.offAll(()=>WecomeScreen());
      loggdin(context);
    });
    super.initState();
  }

  Future<void>loggdin(BuildContext context)async{

    if(user!=null){
      final GetUserDataController getUserDataController= Get.put(GetUserDataController());
      var userData = await getUserDataController.getUserData(user!.uid);
      if(userData[0]['isAdmin']==true){
        Get.offAll(()=>AdminMainScreen());
      }else{
        Get.offAll(()=>MainScreen());
      }
    }else{
      Get.to(()=>WecomeScreen());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appMainColour,
      body: Container(
        child: Center(
         // child:Lottie.asset(name)
          child: Text("Splace Screen",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
