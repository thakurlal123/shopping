import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_card/image_card.dart';
import 'package:shoping/screens/user-panel/single-category-screen.dart';
import 'package:shoping/utils/AppConstant.dart';

import '../../models/categories-model.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColour),
        backgroundColor: AppConstant.appMainColour,
        title: Text("All Categories",style: TextStyle(color: AppConstant.appTextColour),),),
      body: FutureBuilder(

          future: FirebaseFirestore.instance.collection('categories').get(),
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
          CategoriesModel categoriesModel = CategoriesModel(
          categoryId: snapshot.data!.docs[index]['categoryId'],
          categoryImg: snapshot.data!.docs[index]['categoryImg'],
          categoryName: snapshot.data!.docs[index]['categoryName'],
          createdAt: snapshot.data!.docs[index]['createdAt'],
          updatedAt: snapshot.data!.docs[index]['updatedAt'],
          );
          return  Row(children: [
          GestureDetector(
            onTap: (){
              Get.to(()=>SngleCategoryScreen(categoryId: categoriesModel.categoryId,));
            },
            child: Padding(padding: EdgeInsets.all(5.0),
            child: Container(
            child: FillImageCard(
            borderRadius: 20.0,
            width: Get.width/2.2,
            heightImage: Get.height/8.0,
            imageProvider: CachedNetworkImageProvider(categoriesModel.categoryImg,),
            title: Center(child: Text(categoriesModel.categoryName)),
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
