import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/models/cart-model.dart';
import 'package:shoping/models/product-model.dart';
import 'package:shoping/utils/AppConstant.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel? productModel;
   ProductDetailScreen({super.key, required this.productModel});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppConstant.appMainColour,
      title: Text("Product Details",style: TextStyle(color: AppConstant.appTextColour),),
      ),
      body: Container(
        child:Column(
          children: [
            SizedBox(height:Get.height/60),
            //product images
        CarouselSlider(items:widget.productModel?.productImages.map((imageUrls)=>ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
      child: CachedNetworkImage(imageUrl: imageUrls,fit: BoxFit.cover,width: Get.width-10,
        placeholder: (context,url)=>ColoredBox(
          color: Colors.white,
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        ),
        errorWidget: (context,url,error)=>Icon(Icons.error),
      ),
    ),).toList(), options: CarouselOptions(
    scrollDirection: Axis.horizontal,
    autoPlay: true,
    aspectRatio: 2.5,
    viewportFraction: 1
    )),

            Padding(padding: EdgeInsets.all(8.0),

            child:Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${widget.productModel?.productName}"),
                          Icon(Icons.favorite_outline,)
                        ],
                      )),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      alignment: Alignment.topLeft,
                      child: Text("Category: ${widget.productModel?.categoryName}")),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      alignment: Alignment.topLeft,
                      child: Row(

                        children: [
                          widget.productModel?.isSale==true&& widget.productModel?.salePrice!=""?
                          Text("Price: ${widget.productModel?.salePrice}"):Text("Price: ${widget.productModel?.fullPrice}")
                        ],
                      )),
                ),

            Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      alignment: Alignment.topLeft,
                      child: Text("${widget.productModel?.productDescription}")),
                ),

                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(child: Container(
                        decoration: BoxDecoration(
                            color: AppConstant.appSecendoryColour,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        width: Get.width/3,
                        height: Get.height/18,

                        child: TextButton.icon(
                            onPressed: (){}, label: Text("WhatsApp",style: TextStyle(fontWeight: FontWeight.bold,color: AppConstant.appTextColour),)),
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(child: Container(
                        decoration: BoxDecoration(
                            color: AppConstant.appSecendoryColour,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        width: Get.width/3,
                        height: Get.height/18,

                        child: TextButton.icon(
                            onPressed: ()async{
                              checkProductExistence(uId: user!.uid);
                            }, label: Text("Add to cart",style: TextStyle(fontWeight: FontWeight.bold,color: AppConstant.appTextColour),)),
                      ),),
                    ),
                  ],
                ),

              ],
            ),
            ),
            )

          ],
        ),
      ),
    );
  }

  Future<void> checkProductExistence( {required String uId, int quantityIncreament=1})async{

    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('cartOrder')
        .doc(widget.productModel?.productId.toString());

    DocumentSnapshot snapshot = await documentReference.get();

    if(snapshot.exists){
      int currentQuantity = snapshot['productQuantity'];
      int updatedQuantity = currentQuantity+ quantityIncreament;

      double totalPrice = double.parse(widget.productModel!.fullPrice)*updatedQuantity;

      await documentReference.update({
        'productQuantity':updatedQuantity,
        'productTotalPrice':totalPrice
        });
      print("Product exits");
    }else{
      await FirebaseFirestore.instance.collection('cart').doc(uId).set({
        'uId':uId,
        'createdAt':DateTime.now(),
      });
      CartModel cartModel = CartModel(
          productId: widget.productModel!.productId,
          categoryId: widget.productModel!.categoryId,
          productName: widget.productModel!.productName,
          categoryName: widget.productModel!.categoryName,
          salePrice: widget.productModel!.salePrice,
          fullPrice: widget.productModel!.fullPrice,
          productImages: widget.productModel!.productImages,
          deliveryTime: widget.productModel!.deliveryTime,
          isSale: widget.productModel!.isSale,
          productDescription: widget.productModel!.productDescription,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          productQuantity: 1,
          productTotalPrice:double.parse(widget.productModel!.fullPrice));
      await documentReference.set(cartModel.toMap());
    }
    print("Product added");
  }

}
