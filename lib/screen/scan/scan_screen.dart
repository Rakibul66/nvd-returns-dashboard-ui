import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanpackage/controller/barcode_controller.dart';
import 'package:scanpackage/contstants/image_path.dart';


class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  ScanScreenState createState() => ScanScreenState();
}

class ScanScreenState extends State<ScanScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final BarcodeController barcodeController = Get.put(BarcodeController());
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Open the barcode scanner directly when the screen is initialized
    barcodeController.scanBarcode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Scan RMA',
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
              bottomRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Obx(
          () {
            // Display the scanned barcode or loading message
            if (barcodeController.isLoading.value) {
              return CircularProgressIndicator();
            } else if (barcodeController.scannedBarcode.value != 'Unknown') {
              return Text(
                'Scanned Barcode: ${barcodeController.scannedBarcode.value}',
                style: GoogleFonts.inter(fontSize: 16.sp),
              );
            } else {
              return Text(
                'Please scan a barcode',
                style: GoogleFonts.inter(fontSize: 16.sp),
              );
            }
          },
        ),
      ),
    );
  }
}
