import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoping/utils/AppConstant.dart';

import '../screens/auth-ui/welcome-screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: Get.height/25),
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
            bottomRight: Radius.circular(25)
          )
        ),
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Waris",style: TextStyle(color: AppConstant.appTextColour),),
                subtitle: Text("Version 1.0.0",style: TextStyle(color: AppConstant.appTextColour),),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppConstant.appMainColour,
                  child: Text("W",style: TextStyle(color: AppConstant.appTextColour),),
                ),
              ),
            ),
            Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.5,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Home",style: TextStyle(color: AppConstant.appTextColour),),
                leading: Icon(Icons.home,color: AppConstant.appTextColour),
                trailing: Icon(Icons.arrow_forward,color: AppConstant.appTextColour),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Product",style: TextStyle(color: AppConstant.appTextColour),),
                leading: Icon(Icons.production_quantity_limits,color: AppConstant.appTextColour),
                trailing: Icon(Icons.arrow_forward,color: AppConstant.appTextColour),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Orders",style: TextStyle(color: AppConstant.appTextColour),),
                leading: Icon(Icons.shopping_bag,color: AppConstant.appTextColour),
                trailing: Icon(Icons.arrow_forward,color: AppConstant.appTextColour),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Contact",style: TextStyle(color: AppConstant.appTextColour),),
                leading: Icon(Icons.help,color: AppConstant.appTextColour),
                trailing: Icon(Icons.arrow_forward,color: AppConstant.appTextColour),
              ),
            ),Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0,),
              child: ListTile(
                onTap: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  await _auth.signOut();
                  await  googleSignIn.signOut();
                  Get.offAll(()=>WecomeScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Logout",style: TextStyle(color: AppConstant.appTextColour),),
                leading: Icon(Icons.help,color: AppConstant.appTextColour),
                trailing: Icon(Icons.logout,color: AppConstant.appTextColour),
              ),
            ),
          ],
        ) ,
        backgroundColor: AppConstant.appSecendoryColour,
      ),
    );

  }
}
