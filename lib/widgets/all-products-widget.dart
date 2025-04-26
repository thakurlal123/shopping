import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_card/image_card.dart';
import 'package:shoping/models/categories-model.dart';
import 'package:shoping/utils/AppConstant.dart';

import '../models/product-model.dart';
import '../screens/user-panel/product-detail-screen.dart';

class AllProductWidget extends StatelessWidget {
  const AllProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

        future: FirebaseFirestore.instance.collection('products').where('isSale',isEqualTo: false).get(),
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
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: 1.19
              ),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
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
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>ProductDetailScreen(profuctModel: productModel,));
                      //  Get.to(()=>SngleCategoryScreen(categoryId: productModel.productName,));
                    },
                    child: Padding(padding: EdgeInsets.all(5.0),
                      child: Container(
                        child: FillImageCard(
                          borderRadius: 20.0,
                          width: Get.width/2.2,
                          heightImage: Get.height/10.0,
                          imageProvider: CachedNetworkImageProvider(productModel.productImages[0]),
                          title: Center(child: Text(productModel.productName)),
                          footer: Row(
                            children: [
                              Text("Rs ${productModel.fullPrice}",style: TextStyle(fontSize: 10),),

                            ],),
                          //description: Text("data"),
                          //footer: Text("data"),
                        ),
                      ),
                    ),
                  )
                ],);
              }
              ,

            );
          }
          return Container();
        });
  }
}
