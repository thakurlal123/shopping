import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoping/screens/user-panel/all-categories-screen.dart';
import 'package:shoping/utils/AppConstant.dart';

import '../../widgets/all-products-widget.dart';
import '../../widgets/banner-widget.dart';
import '../../widgets/catedory-widget.dart';
import '../../widgets/custom-drewer-widget.dart';
import '../../widgets/flash-sale-widget.dart';
import '../../widgets/heading-widget.dart';
import '../auth-ui/welcome-screen.dart';
import 'all-flash-sale-products.dart';
import 'all-products.dart';
import 'cart-screen.dart';

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
actions: [
  GestureDetector(
      onTap: (){
        Get.to(()=>CartScreen());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.shopping_cart),
      ))
],
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
              onTap: (){
                Get.to(()=>AllCategoriesScreen());
              },
              buttonText: 'See More >',

            ),
            CategoryWidget(),
            HeadingWidget(
              headingTittle: 'Flash sale',
              headingSubTittle: 'Low Budget',
              onTap: (){
                Get.to(()=>AllFlashSaleProducts());
              },
              buttonText: 'See More >',
            ),
            FlashSaleWidget(),
            HeadingWidget(
              headingTittle: 'All Products',
              headingSubTittle: 'Accourding to your budget',
              onTap: (){
                Get.to(()=>AllProduct());
              },
              buttonText: 'See More >',

            ),
            AllProductWidget()
          ],
        ),),
      ),
    );
  }
}
