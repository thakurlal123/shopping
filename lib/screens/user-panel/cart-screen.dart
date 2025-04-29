import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/utils/AppConstant.dart';

import '../../models/cart-model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColour,
        title: Text("Cart Screen"),
      ),
      body:
//       FutureBuilder(
//           future: FirebaseFirestore.instance.collection('cart').get(),
//           builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
//             return Container(
//         child: ListView.builder(
//           itemCount: snapshot.data?.docs.length ,
//             shrinkWrap: true,
//             itemBuilder: (context,index){
//               var product = snapshot.data!.docs[index];
//               CartModel cartModel = CartModel(
//                   productId: product['productId'],
//                   categoryId: product['categoryId'],
//                   productName: product['productName'],
//                   categoryName: product['categoryName'],
//                   salePrice: product['salePrice'],
//                   fullPrice: product['fullPrice'],
//                   productImages: product['productImages'],
//                   deliveryTime: product['deliveryTime'],
//                   isSale: product['isSale'],
//                   productDescription: product['productDescription'],
//                   createdAt: DateTime.now(),
//                   updatedAt: DateTime.now(),
//                   productQuantity: 1,
//                   productTotalPrice:double.parse(product['fullPrice']));
//
//           return Card(
//             elevation: 2,
//             color: AppConstant.appTextColour,
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: AppConstant.appMainColour,
//                 child: Text("${cartModel.productName}"),),
//               title: Text("${cartModel.categoryName}"),
//               subtitle: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("${cartModel.fullPrice}"),
//                  Row(children: [
//                    CircleAvatar(
//                      radius: 14,
//                      backgroundColor: AppConstant.appMainColour,
//                      child: Text("+"),),
//                    SizedBox(width:Get.width/20.0),
//                    CircleAvatar(
//                      radius: 14,
//                      backgroundColor: AppConstant.appMainColour,
//                      child: Text("-"),),
//                  ],)
//                 ],
//               ),
//             ),
//           );
//         })
//       );
//           }),
      Container(
        child: ListView.builder(
          itemCount: 20 ,
            shrinkWrap: true,
            itemBuilder: (context,index){
          return Card(
            elevation: 2,
            color: AppConstant.appTextColour,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppConstant.appMainColour,
                child: Text("T"),),
              title: Text("New Dress for women"),
              subtitle: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("2200"),
                 Row(children: [
                   CircleAvatar(
                     radius: 14,
                     backgroundColor: AppConstant.appMainColour,
                     child: Text("+"),),
                   SizedBox(width:Get.width/20.0),
                   CircleAvatar(
                     radius: 14,
                     backgroundColor: AppConstant.appMainColour,
                     child: Text("-"),),
                 ],)
                ],
              ),
            ),
          );
        })
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 4,top: 4),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total"),
              SizedBox(width: Get.width/60,),
              Text("Rs. 2000",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(width: Get.width/3,),
              Material(child: Container(
                decoration: BoxDecoration(
                    color: AppConstant.appSecendoryColour,
                    borderRadius: BorderRadius.circular(20)
                ),
                width: Get.width/3,
                height: Get.height/20,

                child: TextButton.icon(
                    onPressed: (){}, label: Text("checkout",style: TextStyle(fontWeight: FontWeight.bold,color: AppConstant.appTextColour),)),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
