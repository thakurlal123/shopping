import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/controllers/forgot-password-controller.dart';
import 'package:shoping/controllers/sign-in-controller.dart';
import 'package:shoping/screens/auth-ui/sign-up-screen.dart';
import 'package:shoping/screens/user-panel/main-screen.dart';
import 'package:shoping/utils/AppConstant.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreeState();
}

class _ForgetPasswordScreeState extends State<ForgetPasswordScreen> {
  final ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());
  TextEditingController userEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (BuildContext , bool isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecendoryColour,
            title: Center(child: Text("Forget Password",style: TextStyle(color: AppConstant.appTextColour),)),),
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
                      controller: userEmail,
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
                Material(child: Container(
                  decoration: BoxDecoration(
                      color: AppConstant.appSecendoryColour,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  width: Get.width/2.3,
                  height: Get.height/18,

                  child: TextButton.icon(
                      onPressed: ()async{
                        String email = userEmail.text.trim();

                        if(email.isEmpty){
                          Get.snackbar("Error", "Please enter all details",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecendoryColour,
                              colorText: AppConstant.appTextColour);
                        }else{
                          String email = userEmail.text.trim();
                           await forgotPasswordController.forgetPasswordMethod(email);

                        }

                      }, label: Text("Forget",style: TextStyle(fontWeight: FontWeight.bold,color: AppConstant.appTextColour),)),
                ),),
                SizedBox(height: Get.height/40,),


              ],
            ),
          ),
        );
      },

    );
  }
}
