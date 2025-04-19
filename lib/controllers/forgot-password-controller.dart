import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shoping/models/user-model.dart';
import 'package:shoping/screens/auth-ui/sign-in-screen.dart';
import 'package:shoping/screens/user-panel/main-screen.dart';
import 'package:shoping/utils/AppConstant.dart';

class ForgotPasswordController extends GetxController{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;



  Future<void> forgetPasswordMethod(String userEmail,)async{
    try{
      EasyLoading.show(status: "Please wait");

      await _auth.sendPasswordResetEmail(email: userEmail);
      Get.snackbar("Request Sent Successfully",
          "Password reset link sent to $userEmail",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSecendoryColour,
          colorText: AppConstant.appTextColour
      );
      Get.offAll(()=>SignInScreen());
      EasyLoading.dismiss();


    } on FirebaseAuthException catch(e){
      EasyLoading.dismiss();
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSecendoryColour,
          colorText: AppConstant.appTextColour
      );
    }
  }

}