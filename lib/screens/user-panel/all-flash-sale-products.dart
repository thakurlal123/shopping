import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_card/image_card.dart';
import 'package:shoping/screens/user-panel/product-detail-screen.dart';
import 'package:shoping/screens/user-panel/single-category-screen.dart';

import '../../models/categories-model.dart';
import '../../models/product-model.dart';
import '../../utils/AppConstant.dart';

class AllFlashSaleProducts extends StatefulWidget {
  const AllFlashSaleProducts({super.key});

  @override
  State<AllFlashSaleProducts> createState() => _AllFlashSaleProductsState();
}

class _AllFlashSaleProductsState extends State<AllFlashSaleProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColour),
        backgroundColor: AppConstant.appMainColour,
        title: Text("All Flash Sale Product",style: TextStyle(color: AppConstant.appTextColour),),),
      body: FutureBuilder(

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
              return Center(child: Text("No product found!"),);
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
                        Get.to(()=>ProductDetailScreen(productModel: productModel,));
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
                }
                ,

              );
              //   Container(
              //   height:  Get.height/5.5,
              //   child: ListView.builder(
              //       itemCount: snapshot.data!.docs.length,
              //       shrinkWrap: true,
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (context, index){
              //         CategoriesModel categoriesModel = CategoriesModel(
              //           categoryId: snapshot.data!.docs[index]['categoryId'],
              //           categoryImg: snapshot.data!.docs[index]['categoryImg'],
              //           categoryName: snapshot.data!.docs[index]['categoryName'],
              //           createdAt: snapshot.data!.docs[index]['createdAt'],
              //           updatedAt: snapshot.data!.docs[index]['updatedAt'],
              //         );
              //         return  Row(children: [
              //           Padding(padding: EdgeInsets.all(5.0),
              //             child: Container(
              //               child: FillImageCard(
              //                 borderRadius: 20.0,
              //                 width: Get.width/4.0,
              //                 heightImage: Get.height/12.0,
              //                 imageProvider: CachedNetworkImageProvider(categoriesModel.categoryImg,),
              //                 title: Center(child: Text(categoriesModel.categoryName)),
              //                 //description: Text("data"),
              //                 //footer: Text("data"),
              //               ),
              //             ),
              //           )
              //         ],);
              //       }
              //       ),
              // );
            }
            return Container();
          }),
    );
  }
}
