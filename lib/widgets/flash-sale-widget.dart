import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_card/image_card.dart';
import 'package:shoping/models/categories-model.dart';
import 'package:shoping/screens/user-panel/product-detail-screen.dart';
import 'package:shoping/utils/AppConstant.dart';

import '../models/product-model.dart';

class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

        future: FirebaseFirestore.instance.collection('products').where('isSale',isEqualTo: true).get(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot)
        {
          if(snapshot.hasError){
            return Center(child: Text("Error"),);
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return Container(
              height: Get.height/5,
              child: Center(child: CupertinoActivityIndicator(),),);
          }print(snapshot.data!.docs.length);
          if(snapshot.data!.docs.isEmpty){
            return Center(child: Text("No category found!"),);
          }
          if(snapshot.data!=null){
            return Container(
              height:  Get.height/4.5,
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    var product = snapshot.data!.docs[index];
                    ProductModel productModel = ProductModel(
                        productId: product['productId'],
                        categoryId: product['categoryId'],
                        productName: product['productName'],
                        categoryName: product['categoryName'],
                        salePrice: product['salePrice'],
                        fullPrice: product['fullPrice'],
                        productImages: product['productImages'],
                        deliveryTime: product['deliveryTime'],
                        isSale: product['isSale'],
                        productDescription: product['productDescription'],
                        createdAt: product['createdAt'],
                        updatedAt: product['updatedAt']);
                    // CategoriesModel categoriesModel = CategoriesModel(
                    //   categoryId: snapshot.data!.docs[index]['categoryId'],
                    //   categoryImg: snapshot.data!.docs[index]['categoryImg'],
                    //   categoryName: snapshot.data!.docs[index]['categoryName'],
                    //   createdAt: snapshot.data!.docs[index]['createdAt'],
                    //   updatedAt: snapshot.data!.docs[index]['updatedAt'],
                    // );
                    return  Row(children: [
                      Padding(padding: EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: (){
                            Get.to(()=>ProductDetailScreen(productModel: productModel));
                          },
                          child: Container(
                            child: FillImageCard(
                              borderRadius: 20.0,
                              width: Get.width/4.0,
                              heightImage: Get.height/12.0,
                              imageProvider: CachedNetworkImageProvider(productModel.productImages[0],),

                              title: Center(child: Text(productModel.productName,style: TextStyle(fontSize: 12.0,overflow: TextOverflow.ellipsis),)),
                              footer: Row(
                                children: [
                                  Text("Rs ${productModel.salePrice}",style: TextStyle(fontSize: 10),),
                                  SizedBox(width: 2.0,),
                                  Text("${productModel.fullPrice}",style: TextStyle(color:AppConstant.appSecendoryColour,fontSize: 9,decoration: TextDecoration.lineThrough,overflow: TextOverflow.ellipsis),),

                              ],),
                              //description: Text("data"),
                              //footer: Text("data"),
                            ),
                          ),
                        ),
                      )
                    ],);
                  }),
            );
          }
          return Container();
        });
  }
}
