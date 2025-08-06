import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/controllers/cart-price-controller.dart';
import 'package:shoping/models/order-model.dart';
import 'package:shoping/screens/user-panel/add-reviews-screen.dart';
import 'package:shoping/utils/AppConstant.dart';

import '../../models/cart-model.dart';
import 'checkout-screen.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final  productPriceController =Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColour,
        title: Text("All Orders"),
      ),
      body:
      StreamBuilder(
          stream: FirebaseFirestore.instance.collection('orders').doc(user?.uid).collection('confirmOrders').snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(snapshot.hasError){
              return Center(child: Text("Error"),);
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              return Container(
                height: Get.height/5,
                child: Center(child: CupertinoActivityIndicator(),),);
            }print(snapshot.data!.docs.length);
            if(snapshot.data!.docs.isEmpty){
              return Center(child: Text("No Item found!"),);
            }

            return Container(
                child: ListView.builder(
                    itemCount: snapshot.data?.docs.length ,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      var product = snapshot.data?.docs[index];
                      OrderModel orderModel = OrderModel(
                          productId: product?['productId'],
                          categoryId: product?['categoryId'],
                          productName: product?['productName'],
                          categoryName: product?['categoryName'],
                          salePrice: product?['salePrice'],
                          fullPrice: product?['fullPrice'],
                          productImages: product?['productImages'],
                          deliveryTime: product?['deliveryTime'],
                          isSale: product?['isSale'],
                          productDescription: product?['productDescription'],
                          createdAt: product?['createdAt'],
                          updatedAt: product?['updatedAt'],
                          productQuantity: product?['productQuantity'],
                          productTotalPrice:product?['productTotalPrice'],
                          customerId: product?['customerId'],
                          status: product?['status'],
                          customerName: product?['customerName'],
                          customerPhone: product?['customerPhone'],
                          customerAddress:product?['customerAddress'],
                         customerDeviceToken: product?['customerDeviceToken'],

                      );
                      // productTotalPrice:double.parse(product?['isSale']?product!['salePrice']:product?['fullPrice']));

                      //calculate price
                      productPriceController.fetchProductPrice();

                      return  Card(
                      elevation: 2,
                      color: AppConstant.appTextColour,
                      child: ListTile(
                      leading: CircleAvatar(
                      backgroundColor: AppConstant.appMainColour,
                      backgroundImage: NetworkImage(orderModel.productImages[0]),
                      ),
                      title: Text("${orderModel.productName}"),
                      subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text("${orderModel.productTotalPrice}"),
                        orderModel.status!=true?Text("Pending..",style: TextStyle(color: Colors.green),):Text("Deliverd",style: TextStyle(color: Colors.red),)

                      ],
                      ),
                        trailing: orderModel.status==true?
                        ElevatedButton(onPressed: (){
                          Get.to(AddReviewScreen(orderModel:orderModel));
                        }, child: Text("Review")):SizedBox(),
                      ),
                      );
                    })
            );

          }),


    );
  }
}
