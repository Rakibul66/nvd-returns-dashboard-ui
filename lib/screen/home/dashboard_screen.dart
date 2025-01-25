// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:scanpackage/controller/barcode_controller.dart';
// import 'package:scanpackage/controller/user_controller.dart';
// import 'package:scanpackage/contstants/app_strings.dart';
// import 'package:scanpackage/contstants/colors.dart';
// import 'package:scanpackage/contstants/image_path.dart';
// import 'package:scanpackage/widget/custom_progressbar.dart';

// import '../../widget/returninfo/build_return_method.dart';
// import '../../widget/returninfo/return_meta_data_info.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final BarcodeController barcodeController = Get.put(BarcodeController());
//   final UserController userController = Get.find<UserController>();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _textController = TextEditingController();
//   String? _errorMessage;

//   String? _validateInput(String? value) {
//     if (value == null || value.isEmpty) {
//       setState(() {
//         _errorMessage = 'RMA number cannot be empty';
//       });
//       return ''; // Return a string to indicate validation failure
//     }

//     if (value.length < 6) {
//       setState(() {
//         _errorMessage = 'RMA number must be at least 6 characters';
//       });
//       return ''; // Return a string to indicate validation failure
//     }
//     setState(() {
//       _errorMessage = null; // Clear the error message
//     });
//     return null; // Return null if validation passes
//   }

//   void _submitForm() {
//     barcodeController.changeErrorState(false);
//     if (_formKey.currentState!.validate()) {
//       String rmaCode = _textController.text;
//       barcodeController.submitRMA(rmaCode);
//     }
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetX<BarcodeController>(
//       builder: (controller) {
//         return Scaffold(
//           backgroundColor: Colors.white,
//           body: Stack(
//             children: [
//               CustomScrollView(
//                 slivers: [
//                   _buildGradientHeader(),
//                   barcodeController.rmaData.value == null
//                       ? SliverFillRemaining(
//                           hasScrollBody: false,
//                           child: _buildScanOrEnterRMA(),
//                         )
//                       : SliverToBoxAdapter(child: _buildPackageInformation())
//                 ],
//               ),
//               if (barcodeController.isLoading.value)
//                 Container(
//                   color: Colors.black54,
//                   child: const Center(
//                     child: Center(
//           child: CustomProgressIndicator(
//             backgroundColor: primaryRedColor,
//             color: Colors.orange,
//             strokeWidth: 2.0,
//             strokeCap: StrokeCap.round, // Optional
//           ),
//         )
//                   ),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildGradientHeader() {
//     return SliverAppBar(
//       automaticallyImplyLeading: false,
//       actions: const [SizedBox()],
//       expandedHeight: barcodeController.rmaData.value == null ? 100 : 250,
//       flexibleSpace: FlexibleSpaceBar(
//         background: Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(ImagePaths.statusBarGradient),
//               fit: BoxFit.cover,
//             ),
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(16),
//               bottomRight: Radius.circular(16),
//             ),
//           ),
//           child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             AppStrings.splashTitle,
//                             style: GoogleFonts.roboto(
//                               fontSize: 28,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             AppStrings.appName,
//                             style: GoogleFonts.roboto(
//                               fontSize: 16,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
                     
//                     ],
//                   ),
//                   Obx(() {
//                     return barcodeController.rmaData.value != null
//                         ? Center(
//                             child: Container(
//                               width: double.infinity,
//                               height: 115,
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.8),
//                                 borderRadius: const BorderRadius.only(
//                                   bottomRight: Radius.circular(32),
//                                   topLeft: Radius.circular(6),
//                                   topRight: Radius.circular(6),
//                                   bottomLeft: Radius.circular(6),
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.1),
//                                     blurRadius: 2,
//                                     offset: const Offset(0, 4),
//                                   ),
//                                 ],
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 20, horizontal: 12),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       AppStrings.packageInformation,
//                                       style: GoogleFonts.roboto(
//                                         fontSize: 12,
//                                         color: blackLight,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Obx(() {
//                                       String rmaNumber = barcodeController
//                                               .rmaData.value?.rmaNumber ??
//                                           'N/A';
//                                       String customerName = barcodeController
//                                               .rmaData.value?.name ??
//                                           'N/A';

//                                       return Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'RMA Number: $rmaNumber',
//                                             style: GoogleFonts.roboto(
//                                                 fontSize: 16,
//                                                 color: textLightColor,
//                                                 fontWeight: FontWeight.w600),
//                                           ),
//                                           Text(
//                                             'Customer: $customerName',
//                                             style: GoogleFonts.roboto(
//                                                 fontSize: 16,
//                                                 color: textLightColor,
//                                                 fontWeight: FontWeight.w600),
//                                           ),
//                                         ],
//                                       );
//                                     }),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           )
//                         : const SizedBox();
//                   }),
//                 ],
//                 //
//               ),
//             ),
//           ),
//         ),
//       ),
//       pinned: true,
//       backgroundColor: lightGrey,
//     );
//   }

//   Widget _buildScanOrEnterRMA() {
//     return Form(
//       key: _formKey,
//       child: Container(
     
//         decoration: const BoxDecoration(
//           color: Colors.white,
         
//         ),
//         width: double.infinity,
      
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 48,
//               child: ElevatedButton(
//                 onPressed: () {
//                   barcodeController.scanBarcode();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   side: const BorderSide(
//                     color: lightGreyBorder,
//                     width: 1,
//                   ),
//                   shadowColor: Colors.black.withOpacity(0.5),
//                   elevation: 1,
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Image.asset(
//                       ImagePaths.scanIcon,
//                       width: 24,
//                     ),
//                     const SizedBox(width: 8),
//                     const Text(
//                       AppStrings.scanRma,
//                       style: TextStyle(
//                         color: primaryRedColor,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),
//             const Text(
//               AppStrings.enterRma,
//               style: TextStyle(color: greyBoldColor),
//             ),
//             const SizedBox(height: 12),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Container(
//                 height: 48, // Ensure consistent height
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(
//                     color: _errorMessage == null ? lightGreyBorder : Colors.red,
//                     width: 1,
//                   ),
//                   color: lightGrey,
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: _textController,
//                         validator: _validateInput,
//                         decoration: const InputDecoration(
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 16.0,
//                           ),
//                           hintText: AppStrings.rmaNumber,
//                           hintStyle: TextStyle(
//                             fontSize: 13,
//                             color: textLightColor,
//                           ),
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 48,
//                       child: ElevatedButton(
//                         onPressed: _submitForm,
//                         style: ElevatedButton.styleFrom(
//                           elevation: 0,
//                           backgroundColor: primaryRedColor,
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(8),
//                               bottomRight: Radius.circular(8),
//                             ),
//                           ),
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 16),
//                           child: Text(
//                             AppStrings.buttonSubmit,
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             if (_errorMessage != null)
//               Text(
//                 _errorMessage!,
//                 style: GoogleFonts.inter(
//                   color: Colors.red,
//                   fontSize: 13,
//                 ),
//               ),
//             // Error message section
//             ValueListenableBuilder<bool>(
//               valueListenable: barcodeController.fetchErrorNotifier,
//               builder: (context, hasError, child) {
//                 return AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//                   height: hasError
//                       ? 20
//                       : 0, // Set height dynamically based on error
//                   margin: const EdgeInsets.only(top: 12),
//                   child: hasError
//                       ? const Text(
//                           AppStrings.rmaInvalid,
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.red,
//                           ),
//                         )
//                       : const SizedBox.shrink(),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPackageInformation() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 6.0),
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Obx(() {
//                 final rmaData = barcodeController.rmaData.value;
//                 if (rmaData != null) {
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Left side text widgets
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Shipment Received: ${barcodeController.rmaData.value!.shipmentRecive}',
//                                   style: const TextStyle(
//                                       fontSize: 16, color: textLightColor),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   'Return Variants: ${barcodeController.rmaData.value!.returnVariants.length}',
//                                   style: const TextStyle(
//                                       fontSize: 16, color: textLightColor),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 RichText(
//                                   text: TextSpan(
//                                     children: [
//                                       const TextSpan(
//                                         text: 'Status: ',
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             color: textLightColor),
//                                       ),
//                                       TextSpan(
//                                         text: barcodeController
//                                             .rmaData.value!.status,
//                                         style: const TextStyle(
//                                             fontSize: 16, color: Colors.red),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           Container(
//                             width: 92,
//                             height: 72,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(
//                                 color: lightGreyBorder,
//                                 width: 1,
//                               ),
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Image.asset(
//                                   ImagePaths.scanner,
//                                   width: 24,
//                                   height: 24,
//                                   color: redColor,
//                                 ),
//                                 const SizedBox(height: 8),
//                                 const Text(
//                                   AppStrings.scanRma,
//                                   style:
//                                       TextStyle(fontSize: 14, color: redColor),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 16),

//                       buildReturnItems(rmaData.returnVariants),
//                       const SizedBox(height: 8),
//                       // Card for Customer Info
//                       SizedBox(
//                         width: double.infinity,
//                         child: Card(
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             side: const BorderSide(
//                                 color: Color(0xFFEBEBEB),
//                                 width: 1), // Soft grey border
//                           ),
//                           color: Colors.white,
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   AppStrings.customerInfo,
//                                   style: GoogleFonts.roboto(
//                                     fontSize: 18,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Text('Name: ${rmaData.name}',
//                                     style: GoogleFonts.roboto(fontSize: 16)),
//                                 Text('Email: ${rmaData.customerEmail}',
//                                     style: GoogleFonts.roboto(fontSize: 16)),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       // Shipping Info Widget
//                       rmaData.returnShipping != null
//                           ? buildReturnMethod(
//                               rmaData.returnShipping!,
//                             )
//                           : const SizedBox()
//                     ],
//                   );
//                 } else {
//                   return const SizedBox();
//                 }
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }