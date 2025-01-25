import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scanpackage/controller/barcode_controller.dart';
import 'package:scanpackage/contstants/colors.dart';
import 'package:scanpackage/contstants/image_path.dart';
import 'package:scanpackage/data/return_queue_model.dart';
import 'package:scanpackage/network/api_service.dart';
import 'package:scanpackage/screen/home/result_screen.dart';
import 'package:scanpackage/widget/custom_progressbar.dart';

class ReturnQueueScreen extends StatefulWidget {
  const ReturnQueueScreen({super.key});

  @override
  State<ReturnQueueScreen> createState() => _ReturnQueueScreenState();
}

class _ReturnQueueScreenState extends State<ReturnQueueScreen> {
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
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Returns Queue',
          style: TextStyle(
            fontSize: 18.sp, 
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
    
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
   body: FutureBuilder<List<ReturnQueueModel>>(
  future: returnQueueLists,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CustomProgressIndicator(
          backgroundColor: primaryRedColor,
          color: Colors.orange,
          strokeWidth: 2.0,
          strokeCap: StrokeCap.round, // Optional
        ),
      );
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData) {
      if (snapshot.data!.isEmpty) {
        // Handle empty array case
        return const Center(
          child: Text(
            'No data found.',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        );
      } else {
        // Display data if available
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final returnData = snapshot.data![index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h),
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text('Order: ${returnData.name}'),
                      subtitle: Text('Status: ${returnData.status}\n'
                          'Country: ${returnData.country}'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Get.to(
                          () => const ResultScreen(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 300),
                        );
                        barcodeController.submitRMA(returnData.rmaNumber);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
    } else {
      return const Center(child: Text('No data found.'));
    }
  },
),

    );
  }
}
