import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoping/utils/AppConstant.dart';

import '../../widgets/banner-widget.dart';
import '../../widgets/custom-drewer-widget.dart';
import '../../widgets/heading-widget.dart';
import '../auth-ui/welcome-screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColour),
        backgroundColor: AppConstant.appMainColour,
        title: Center(child: Text(AppConstant.appMainName,style: TextStyle(color: AppConstant.appTextColour),)),

      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(child: Column(
          children: [
            SizedBox(height: Get.height/90,),

            //banners
            BannerWidget(),
            //headingWidget
            HeadingWidget(
              headingTittle: 'Categories',
              headingSubTittle: 'Low Budget',
              onTap: (){},
              buttonText: 'See More >',

            ),
            HeadingWidget(
              headingTittle: 'Flash Sale',
              headingSubTittle: 'Accourding to your Budget',
              onTap: (){},
              buttonText: 'See More >',

            ),
          ],
        ),),
      ),
    );
  }
}
