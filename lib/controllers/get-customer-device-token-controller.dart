
import 'package:firebase_messaging/firebase_messaging.dart';

Future<String?> getCustmerDeviceToken()async{
  try{
    String? token = await FirebaseMessaging.instance.getToken();
    if(token!=null){
      return token;
    }else{
      throw Exception("Error");
    }
  } catch(e){
print("Error $e");
      }
}