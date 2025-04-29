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

class AllProduct extends StatefulWidget {
  const AllProduct({super.key});

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColour),
        backgroundColor: AppConstant.appMainColour,
        title: Text("All Product",style: TextStyle(color: AppConstant.appTextColour),),),
      body: FutureBuilder(

          future: FirebaseFirestore.instance.collection('products').get(),
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
                            footer: Center(child: Text("Rs ${productModel.salePrice}",style: TextStyle(fontSize: 10),)),
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
