import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scanpackage/contstants/colors.dart';
import 'package:scanpackage/contstants/image_path.dart';
import '../../widget/questions/customer_qna.dart'; 

class InspectScreen extends StatefulWidget {
  final String title;
   final int itemId;          
  final String shopUrl; 

  const InspectScreen({
    super.key,
    required this.title,
      required this.itemId,      
    required this.shopUrl, 
  });

  @override
  InspectScreenState createState() => InspectScreenState();
}

class InspectScreenState extends State<InspectScreen> {
  bool isManualReviewEnabled = false;
  bool isRestockEnabled = false;
  String? selectedCondition;
  int? receivedQuantity;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 18.sp, // Make text responsive
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagePaths.statusBarGradient),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(16),bottomLeft: Radius.circular(16)
            ),
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
                bottomLeft: Radius.circular(6),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Image.asset(
                ImagePaths.arrow,
                width: 24.w,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomerQnA(
                itemID: widget.itemId,
                shopUrl: widget.shopUrl,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
