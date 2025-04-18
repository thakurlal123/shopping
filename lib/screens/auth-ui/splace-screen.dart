import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:shoping/screens/auth-ui/welcome-screen.dart';
import 'package:shoping/screens/user-panel/main-screen.dart';
import 'package:shoping/utils/AppConstant.dart';

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({super.key});

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), (){
      Get.offAll(()=>WecomeScreen());
    });
    super.initState();
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
