import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/screens/auth-ui/sign-up-screen.dart';
import 'package:shoping/utils/AppConstant.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (BuildContext , bool isKeyboardVisible) {
       return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecendoryColour,
            title: Center(child: Text("Singn In",style: TextStyle(color: AppConstant.appTextColour),)),),
         body: Container(
           child: Column(
             children: [
               isKeyboardVisible?SizedBox.shrink():
               Column(
                 children: [
                   Container(color: AppConstant.appSecendoryColour,
                     height: Get.height/2.4,
                     width: Get.width,
                     child: Center(child: Text("Welcome",style: TextStyle(color: AppConstant.appTextColour,fontSize: 20),)),
                   )
                 ],
               ),
               SizedBox(height: Get.height/20,),
               Container(
                   margin: EdgeInsets.symmetric(horizontal: 5.0),
                   child: TextFormField(
                     cursorColor: AppConstant.appMainColour,
                     keyboardType: TextInputType.emailAddress,
                     decoration: InputDecoration(
                       hintText: "Email",
                       prefixIcon: Icon(Icons.email),
                       contentPadding: EdgeInsets.only(top: 2,left: 8),
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
                     ),
                   )),
               SizedBox(height: Get.height/20,),
               Container(
                   margin: EdgeInsets.symmetric(horizontal: 5.0),
                   child: TextFormField(
                     cursorColor: AppConstant.appMainColour,
                     keyboardType: TextInputType.emailAddress,
                     decoration: InputDecoration(
                       hintText: "Password",
                       prefixIcon: Icon(Icons.password),
                       suffixIcon: Icon(Icons.visibility_off),
                       contentPadding: EdgeInsets.only(top: 2,left: 8),
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
                     ),
                   )),
               SizedBox(height: Get.height/50,),
               Container(
                 margin: EdgeInsets.symmetric(horizontal: 10.0),
                 alignment: Alignment.centerRight,
                 child: Text("Forget Password?",
                 style: TextStyle(color: AppConstant.appSecendoryColour,fontWeight: FontWeight.bold),
                 ),
               ),
               SizedBox(height: Get.height/40,),
               Material(child: Container(
                 decoration: BoxDecoration(
                     color: AppConstant.appSecendoryColour,
                     borderRadius: BorderRadius.circular(20)
                 ),
                 width: Get.width/2.3,
                 height: Get.height/18,

                 child: TextButton.icon(
                     onPressed: (){}, label: Text("SIGN IN",style: TextStyle(fontWeight: FontWeight.bold,color: AppConstant.appTextColour),)),
               ),),
               SizedBox(height: Get.height/40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",style: TextStyle(color: AppConstant.appMainColour),),
                  GestureDetector(
                      onTap: (){
                        Get.offAll(()=>SignUpScreen());
                      },
                      child: Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold,color: AppConstant.appMainColour),))

                ],
              ),

             ],
           ),
         ),
        );
      },

    );
  }
}
