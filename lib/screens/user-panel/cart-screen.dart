import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/controllers/cart-price-controller.dart';
import 'package:shoping/utils/AppConstant.dart';

import '../../models/cart-model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
User? user = FirebaseAuth.instance.currentUser;
final  productPriceController =Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColour,
        title: Text("Cart Screen"),
      ),
      body:
      StreamBuilder(
          stream: FirebaseFirestore.instance.collection('cart').doc(user?.uid).collection('cartOrder').snapshots(),
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
                        CartModel cartModel = CartModel(
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
                            productTotalPrice:product?['productTotalPrice']);
                           // productTotalPrice:double.parse(product?['isSale']?product!['salePrice']:product?['fullPrice']));

                        //calculate price
                        productPriceController.fetchProductPrice();

                        return SwipeActionCell(
                          key: ObjectKey(cartModel.productId),
                          trailingActions: [SwipeAction(
                              title: "Delete",
                              forceAlignmentToBoundary: true,
                              performsFirstActionWithFullSwipe: true,
                              onTap: (CompletionHandler handler)async{

                                FirebaseFirestore
                                    .instance
                                    .collection('cart')
                                    .doc(user!.uid)
                                    .collection('cartOrder')
                                    .doc(cartModel.productId).delete();

                              })],
                          child: Card(
                            elevation: 2,
                            color: AppConstant.appTextColour,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: AppConstant.appMainColour,
                                backgroundImage: NetworkImage(cartModel.productImages[0]),
                              ),
                              title: Text("${cartModel.productName}"),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${cartModel.productTotalPrice}"),
                                  Row(children: [
                                    GestureDetector(
                                      onTap: () async {

                                        if(cartModel.productQuantity>0){
                                          await FirebaseFirestore.instance
                                              .collection('cart').doc(user!.uid)
                                              .collection('cartOrder').doc(cartModel.productId).update({
                                            'productQuantity':cartModel.productQuantity+1,
                                            'productTotalPrice':(
                                              //  double.parse(cartModel.fullPrice)+
                                                double.parse(cartModel.isSale?cartModel.salePrice:cartModel.fullPrice)*
                                                    (cartModel.productQuantity+1)),
                                          });
                                        }
                                      },
                                      child: CircleAvatar(
                                        radius: 14,
                                        backgroundColor: AppConstant.appMainColour,
                                        child: Text("+"),),
                                    ),
                                    SizedBox(width:Get.width/30.0),
                                    Text("${cartModel.productQuantity}"),
                                    SizedBox(width:Get.width/30.0),
                                    GestureDetector(
                                      onTap: ()async{
                                        if(cartModel.productQuantity>1){
                                          await FirebaseFirestore.instance
                                              .collection('cart').doc(user!.uid)
                                              .collection('cartOrder').doc(cartModel.productId).update({
                                            'productQuantity':cartModel.productQuantity-1,
                                            'productTotalPrice':(double.parse(cartModel.isSale?cartModel.salePrice:cartModel.fullPrice)*(cartModel.productQuantity-1)),
                                          });
                                        }
                                      },
                                      child: CircleAvatar(
                                        radius: 14,
                                        backgroundColor: AppConstant.appMainColour,
                                        child: Text("-"),),
                                    ),
                                  ],)
                                ],
                              ),
                            ),
                          ),
                        );
                      })
              );

          }),
//       Container(
//         child: ListView.builder(
//           itemCount: 20 ,
//             shrinkWrap: true,
//             itemBuilder: (context,index){
//           return Card(
//             elevation: 2,
//             color: AppConstant.appTextColour,
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: AppConstant.appMainColour,
//                 child: Text("T"),),
//               title: Text("New Dress for women"),
//               subtitle: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("2200"),
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
//       ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 4,top: 4),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text("Total"),
              // SizedBox(width: Get.width/60,),
             Obx(()=> Text("Total Rs. ${productPriceController.totalPrice}",style: TextStyle(fontWeight: FontWeight.bold),),),
              SizedBox(width: Get.width/3.5,),
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
