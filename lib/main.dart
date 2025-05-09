import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shoping/screens/auth-ui/sign-in-screen.dart';
import 'package:shoping/screens/auth-ui/sign-up-screen.dart';
import 'package:shoping/screens/auth-ui/splace-screen.dart';

import 'firebase_options.dart';
import 'screens/user-panel/main-screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplaceScreen(),
      builder: EasyLoading.init(),
    );
  }
}



// 4  done
//11 done
//14 done
//18 done
//20 done
//26 done and 27 at 3:10
//30 done
//32
//35