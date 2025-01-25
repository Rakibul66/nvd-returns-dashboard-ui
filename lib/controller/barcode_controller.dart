import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:scanpackage/data/rma_data.dart';
import 'package:scanpackage/network/api_service.dart';
import 'package:scanpackage/screen/home/result_screen.dart';

class BarcodeController extends GetxController {
  var scannedBarcode = 'Unknown'.obs;
  RxBool isLoading = false.obs;
  var rmaData = Rxn<RmaData>(); // To store the RMA data
  final ApiService apiService = Get.put(ApiService());

  // ValueNotifier to expose fetchError as ValueListenable
  ValueNotifier<bool> fetchErrorNotifier = ValueNotifier(false);

  // Method to scan a barcode

  void changeErrorState(bool status) {
    fetchErrorNotifier.value = status;
  }

  Future<void> scanBarcode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', // Color for the scan line
        'Cancel', // Cancel button text
        true, // Show flash icon
        ScanMode.BARCODE, // Scan mode (BARCODE/QR)
      );
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If scanning is successful, update the scanned barcode and call the API
    if (barcodeScanRes != '-1') {
      scannedBarcode.value = barcodeScanRes;

      // Generate a hash from the barcode without any secret key
      String hashedMessage = hashMessage(barcodeScanRes);

      // Send the hashed message (or barcode) to the API
      fetchRmaDetails(barcodeScanRes, hashedMessage);
    }
  }

  Future<void> submitRMA(String code) async {
    try {
      rmaData.value = null;
      String hashedMessage = hashMessage(code);
      await fetchRmaDetails(code, hashedMessage);
    } catch (e) {
      rmaData.value = null;
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Method to hash the scanned barcode using SHA-256
  String hashMessage(String message) {
    var bytes = utf8.encode(message); // Convert message to bytes
    var digest = sha256.convert(bytes); // Perform SHA-256 hashing
    return digest.toString(); // Return the hashed message (SHA-256 result)
  }

  // Fetch RMA details from the API using the scanned barcode and hashed message
  Future<void> fetchRmaDetails(String rmaNumber, String hashedMessage) async {
    isLoading.value = true;

    fetchErrorNotifier.value = false; // Reset the ValueNotifier

    final RmaData? fetchedRmaData =
        await apiService.fetchRmaData(rmaNumber, hashedMessage);
    if (fetchedRmaData != null) {
      rmaData.value = fetchedRmaData;
      // Store the fetched RMA data
      fetchErrorNotifier.value = false; // Update ValueNotifier
      Get.to(ResultScreen());
    } else {
      rmaData.value = null;
      fetchErrorNotifier.value = true; // Update ValueNotifier
    }
    isLoading.value = false;
  }
}
