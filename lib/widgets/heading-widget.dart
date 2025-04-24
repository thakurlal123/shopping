import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoping/utils/AppConstant.dart';

class HeadingWidget extends StatelessWidget {
  final String headingTittle;
  final String headingSubTittle;
  final VoidCallback onTap;
  final String buttonText;
   HeadingWidget({
     super.key,
     required this.headingTittle,
     required this.headingSubTittle,
     required this.onTap,
     required this.buttonText
   });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
      child: Padding(padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(headingTittle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800
                
                ),),
              Text(headingSubTittle,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                  color: Colors.grey

                ),),
              
            ],
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: AppConstant.appSecendoryColour,
                  width: 1.5
                ),
              ),
              child:Padding(padding: EdgeInsets.all(8.0),
                child:  Text(buttonText,style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                  color: AppConstant.appSecendoryColour
                ),),

              )
            ),
          )
        ],
      ),
      ),
      
    );
  }
}
