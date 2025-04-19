import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/controllers/sign-in-controller.dart';
import 'package:shoping/screens/auth-ui/forget-password-sreen.dart';
import 'package:shoping/screens/auth-ui/sign-up-screen.dart';
import 'package:shoping/screens/user-panel/main-screen.dart';
import 'package:shoping/utils/AppConstant.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController signInController = Get.put(SignInController());
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
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
               Container(
                   margin: EdgeInsets.symmetric(horizontal: 5.0),
                   child: Obx(()=>TextFormField(
                     controller: userPassword,
                     cursorColor: AppConstant.appMainColour,
                     keyboardType: TextInputType.emailAddress,
                     obscureText: signInController.isPasswordVisible.value,
                     decoration: InputDecoration(
                         hintText: "Password",
                         prefixIcon: Icon(Icons.password),
                         suffixIcon: GestureDetector(
                             onTap: (){
                               signInController.isPasswordVisible.toggle();
                             },
                             child: signInController.isPasswordVisible.value?Icon(Icons.visibility):Icon(Icons.visibility_off)),
                         contentPadding: EdgeInsets.only(top: 2,left: 8),
                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
                     ),
                   ))
               ),
               SizedBox(height: Get.height/50,),
               Container(
                 margin: EdgeInsets.symmetric(horizontal: 10.0),
                 alignment: Alignment.centerRight,
                 child: GestureDetector(
                   onTap: (){
                     Get.to(()=>ForgetPasswordScreen());
                   },
                   child: Text("Forget Password?",
                   style: TextStyle(color: AppConstant.appSecendoryColour,fontWeight: FontWeight.bold),
                   ),
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
                     onPressed: ()async{
                       String email = userEmail.text.trim();
                       String password = userPassword.text.trim();
                       if(email.isEmpty||password.isEmpty){
                         Get.snackbar("Error", "Please enter all details",
                             snackPosition: SnackPosition.BOTTOM,
                             backgroundColor: AppConstant.appSecendoryColour,
                             colorText: AppConstant.appTextColour);
                       }else{
                         UserCredential? userCreadential = await signInController.signInMethod(email, password);

                         if(userCreadential!=null){
                           if(userCreadential.user!.emailVerified){
                             Get.snackbar("Sucess", "login Successfully",
                                 snackPosition: SnackPosition.BOTTOM,
                                 backgroundColor: AppConstant.appSecendoryColour,
                                 colorText: AppConstant.appTextColour);
                             Get.offAll(()=>MainScreen());
                           }else{
                             Get.snackbar("Error", "Please verify your email before login",
                                 snackPosition: SnackPosition.BOTTOM,
                                 backgroundColor: AppConstant.appSecendoryColour,
                                 colorText: AppConstant.appTextColour);
                           }
                         }else{
                           Get.snackbar("Error", "Please try again",
                               snackPosition: SnackPosition.BOTTOM,
                               backgroundColor: AppConstant.appSecendoryColour,
                               colorText: AppConstant.appTextColour);
                         }
                       }

                     }, label: Text("SIGN IN",style: TextStyle(fontWeight: FontWeight.bold,color: AppConstant.appTextColour),)),
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
