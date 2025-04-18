import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/utils/AppConstant.dart';

class WecomeScreen extends StatefulWidget {
  const WecomeScreen({super.key});

  @override
  State<WecomeScreen> createState() => _WecomeScreenState();
}

class _WecomeScreenState extends State<WecomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: AppConstant.appSecendoryColour,
      appBar: AppBar(
        backgroundColor: AppConstant.appSecendoryColour,
        title: Center(child: Text("Welcome to my app",style: TextStyle(color: AppConstant.appTextColour),)),),
      body: Container(
        child: Column(
          children: [
            Container(
              height: Get.height/2.2,
              color: AppConstant.appSecendoryColour,
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child:  Text("Happy Shopping",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            SizedBox(height: Get.height/12,),
            Material(child: Container(
              decoration: BoxDecoration(
                color: AppConstant.appSecendoryColour,
                borderRadius: BorderRadius.circular(20)
              ),
              width: Get.width/1.2,
              height: Get.height/12,
              
              child: TextButton.icon(
                  icon: Icon(Icons.g_mobiledata_outlined,color: Colors.yellowAccent,),
                  onPressed: (){}, label: Text("Sing in with google",style: TextStyle(color: AppConstant.appTextColour),)),
            ),),
            SizedBox(height: Get.height/40,),
            Material(child: Container(
              decoration: BoxDecoration(
                color: AppConstant.appSecendoryColour,
                borderRadius: BorderRadius.circular(20)
              ),
              width: Get.width/1.2,
              height: Get.height/12,

              child: TextButton.icon(
                  icon: Icon(Icons.email,color: Colors.yellowAccent,),
                  onPressed: (){}, label: Text("Sing in with Email",style: TextStyle(color: AppConstant.appTextColour),)),
            ),)


          ],
        ),
      ),

    );
  }
}
