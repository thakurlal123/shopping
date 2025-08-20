import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shoping/controllers/cart-price-controller.dart';
import 'package:shoping/controllers/get-customer-device-token-controller.dart';
import 'package:shoping/utils/AppConstant.dart';

import '../../models/cart-model.dart';
import '../../services/place-order-service.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final  productPriceController =Get.put(ProductPriceController());
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  late Razorpay _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColour),
        backgroundColor: AppConstant.appMainColour,
        title: Text("CheckOut",
            style: TextStyle(color: AppConstant.appTextColour),),
      ),
      body:
      StreamBuilder(
          stream: FirebaseFirestore.instance.collection('cart').doc(user?.uid).collection('cartOrders').snapshots(),
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

                              ],
                            ),
                          ),
                        ),
                      );
                    })
            );

          }),

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
                    onPressed: (){
                        showCustomBottemSheet();
                    }, label: Text("Conferm Order",style: TextStyle(fontWeight: FontWeight.bold,color: AppConstant.appTextColour),)),
              ),),
            ],
          ),
        ),
      ),
    );
  }
  void showCustomBottemSheet(){
    Get.bottomSheet(
        Container(
          height: Get.height*.8,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16.0),
              )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                  child: Container(
                    height: 55,
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: "Name",
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                          hintStyle: TextStyle(
                            fontSize:12,
                          )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                  child: Container(
                    height: 55,
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Phone",
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                          hintStyle: TextStyle(
                            fontSize:12,
                          )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                  child: Container(
                    height: 55,
                    child: TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                          labelText: "Address",
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                          hintStyle: TextStyle(
                            fontSize:12,
                          )
                      ),
                    ),
                  ),
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstant.appMainColour,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10)
                    ),
                    onPressed: () async {
                     if( nameController.text!=""&&
                         phoneController.text!=""&&
                         addressController.text!=""){

                       _openCheckout();



                     }else{
                       print("Please Fill All");
                     }

                    }, child: Text("Place Order",style: TextStyle(color: Colors.white),))
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        isDismissible: true,
        elevation: 6
    );
  }

  void _openCheckout() {
   double price = productPriceController.totalPrice.value*100;
   print("price $price");
    var options = {
      'key': 'rzp_test_gEpgNzxUARWd2k',
      'amount': price, // amount in paise (1000 = ₹10.00)
      'currency': 'INR',
      'name': nameController.text!,
      'description': 'Fine T-Shirt',
      'prefill': {
        'contact': phoneController.text!,
        'email': 'test@razorpay.com'
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response)   {
    // Do something when payment succeeds
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String address = addressController.text.trim();
    //String? customerToken =   getCustmerDeviceToken();

    //place order
    placeOrder(
        context:context,
        customerName:name,
        customerPhone:phone,
        cutomerAddress:address,
        customerDeviceToken:"customerToken"
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

}
