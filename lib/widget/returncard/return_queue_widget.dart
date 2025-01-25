import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scanpackage/controller/barcode_controller.dart';
import 'package:scanpackage/contstants/colors.dart';
import 'package:scanpackage/data/return_queue_model.dart';
import 'package:scanpackage/network/api_service.dart';
import 'package:scanpackage/screen/home/result_screen.dart';// Import the ReturnQueueScreen
import 'package:scanpackage/screen/queue/return_queue_screen.dart';
import 'package:scanpackage/widget/custom_progressbar.dart';

class ReturnQueueWidget extends StatefulWidget {
  const ReturnQueueWidget({super.key});

  @override
  State<ReturnQueueWidget> createState() => _ReturnQueueWidgetState();
}

class _ReturnQueueWidgetState extends State<ReturnQueueWidget> {
  final BarcodeController barcodeController = Get.find<BarcodeController>();
  late Future<List<ReturnQueueModel>> returnQueueLists;
  ApiService apiService = Get.put(ApiService());

  @override
  void initState() {
    super.initState();
    returnQueueLists = apiService.fetchReturnQueueLists();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReturnQueueModel>>(
      future: returnQueueLists,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CustomProgressIndicator(
              backgroundColor: primaryRedColor,
              color: Colors.orange,
              strokeWidth: 2.0,
              strokeCap: StrokeCap.round,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const SizedBox.shrink(); // No space taken when data is empty
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Return Queue',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: textLightColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const ReturnQueueScreen()); // Navigate to ReturnQueueScreen
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
               Flexible(
  child: ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    // Show only up to 4 items, or less if there are fewer than 4 in the data
    itemCount: snapshot.data!.length > 4 ? 4 : snapshot.data!.length,
    itemBuilder: (context, index) {
      final returnData = snapshot.data![index];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Order: ${returnData.name}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    returnData.status,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Country: ${returnData.country}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => const ResultScreen(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 300),
                      );
                      barcodeController.submitRMA(returnData.rmaNumber);
                    },
                    child: Row(
                      children: [
                        Text(
                          'View Details',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  ),
),

              ],
            ),
          );
        }

        return const SizedBox.shrink(); 
      },
    );
  }
}
