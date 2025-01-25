import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanpackage/controller/barcode_controller.dart';
import 'package:scanpackage/controller/user_controller.dart';
import 'package:scanpackage/contstants/app_strings.dart';
import 'package:scanpackage/contstants/colors.dart';
import 'package:scanpackage/contstants/image_path.dart';
import 'package:scanpackage/widget/custom_progressbar.dart';
import '../../widget/returninfo/build_return_method.dart';
import '../../widget/returninfo/return_meta_data_info.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final BarcodeController barcodeController = Get.put(BarcodeController());
  final UserController userController = Get.find<UserController>();
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<BarcodeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar:AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Package Information',
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
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    _buildGradientHeader(),  // Replace with a container or header widget if needed
                    barcodeController.rmaData.value == null
                        ?  SizedBox(
                            height: 100,
                            child: Container(),
                          )
                        : _buildPackageInformation(),
                  ],
                ),
              ),
              if (barcodeController.isLoading.value)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CustomProgressIndicator(
                      backgroundColor: primaryRedColor,
                      color: Colors.orange,
                      strokeWidth: 2.0,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGradientHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            return barcodeController.rmaData.value != null
                ? Center(
                    child: Container(
                      width: double.infinity,
                      height: 125,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.packageInformation,
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: blackLight,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Obx(() {
                              String rmaNumber = barcodeController.rmaData.value?.rmaNumber ?? 'N/A';
                              String customerName = barcodeController.rmaData.value?.name ?? 'N/A';
    
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'RMA Number: $rmaNumber',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      color: textLightColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Customer: $customerName',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      color: textLightColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox();
          }),
        ],
      ),
    );
  }

  Widget _buildPackageInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                final rmaData = barcodeController.rmaData.value;
                if (rmaData != null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Shipment Received: ${barcodeController.rmaData.value!.shipmentRecive}',
                                  style: const TextStyle(fontSize: 16, color: textLightColor),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Return Variants: ${barcodeController.rmaData.value!.returnVariants.length}',
                                  style: const TextStyle(fontSize: 16, color: textLightColor),
                                ),
                                const SizedBox(height: 4),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Status: ',
                                        style: TextStyle(fontSize: 16, color: textLightColor),
                                      ),
                                      TextSpan(
                                        text: barcodeController.rmaData.value!.status,
                                        style: const TextStyle(fontSize: 13, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      buildReturnItems(rmaData.returnVariants),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
                          ),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.customerInfo,
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text('Name: ${rmaData.name}', style: GoogleFonts.roboto(fontSize: 16)),
                                Text('Email: ${rmaData.customerEmail}', style: GoogleFonts.roboto(fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      rmaData.returnShipping != null
                          ? buildReturnMethod(rmaData.returnShipping!)
                          : const SizedBox(),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
