import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/controllers/sign-up-controller.dart';
import 'package:shoping/screens/auth-ui/sign-in-screen.dart';

import '../../utils/AppConstant.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userCity = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (BuildContext , bool isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecendoryColour,
            title: Center(child: Text("Sign Up",style: TextStyle(color: AppConstant.appTextColour),)),),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: Get.height/20,),
                  Center(child: Text("Welcome to my app",style: TextStyle(fontSize: 24,color: AppConstant.appMainColour,fontWeight: FontWeight.bold),)),
                  SizedBox(height: Get.height/20,),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: TextFormField(
                        controller: userName,
                        cursorColor: AppConstant.appMainColour,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: "UserName",
                            prefixIcon: Icon(Icons.person),
                            contentPadding: EdgeInsets.only(top: 2,left: 8),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
                        ),
                      )),
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
                      child: TextFormField(
                        controller: userPhone,
                        cursorColor: AppConstant.appMainColour,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Phone",
                            prefixIcon: Icon(Icons.call),
                            contentPadding: EdgeInsets.only(top: 2,left: 8),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
                        ),
                      )),
                  SizedBox(height: Get.height/20,),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: TextFormField(
                        controller: userCity,
                        cursorColor: AppConstant.appMainColour,
                       // keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "City",
                            prefixIcon: Icon(Icons.location_pin),
                            contentPadding: EdgeInsets.only(top: 2,left: 8),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
                        ),
                      )),
                  SizedBox(height: Get.height/20,),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Obx(()=>TextFormField(
                        obscureText: signUpController.isPasswordVisible.value,
                        controller: password,
                        cursorColor: AppConstant.appMainColour,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: GestureDetector(
                                onTap: (){
                                  signUpController.isPasswordVisible.toggle();
                                },
                                child:signUpController.isPasswordVisible.value? Icon(Icons.visibility_off):Icon(Icons.visibility)),
                            contentPadding: EdgeInsets.only(top: 2,left: 8),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
                        ),
                      ))
                  
                  ),
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
                        onPressed: () async {

                          String name = userName.text.trim();
                          String email = userEmail.text.trim();
                          String phone = userPhone.text.trim();
                          String city = userCity.text.trim();
                          String passwo = password.text.trim();
                          String userDeviceToken = '';
                          if(name.isEmpty|| email.isEmpty|| phone.isEmpty||city.isEmpty||passwo.isEmpty){
                            Get.snackbar("Error", "Please Enter All Details",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecendoryColour,
                                colorText: AppConstant.appTextColour

                            );
                          }else{
                            UserCredential? userCreadential =await signUpController.signUpMethod(name, email, phone, city, passwo, userDeviceToken);
                            if(userCreadential!=null){
                              Get.snackbar("Varification Email sent", "Please check yur email",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppConstant.appSecendoryColour,
                                  colorText: AppConstant.appTextColour
                              );
                              FirebaseAuth.instance.signOut();
                              Get.offAll(SignInScreen());
                            }
                          }

                        }, label: Text("SIGN UP",style: TextStyle(fontWeight: FontWeight.bold,color: AppConstant.appTextColour),)),
                  ),),
                  SizedBox(height: Get.height/50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",style: TextStyle(color: AppConstant.appMainColour),),
                      GestureDetector(
                          onTap: (){
                            Get.offAll(()=>SignInScreen());
                          },
                          child: Text("Sign In",style: TextStyle(fontWeight: FontWeight.bold,color: AppConstant.appMainColour),))

                    ],
                  ),

                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
