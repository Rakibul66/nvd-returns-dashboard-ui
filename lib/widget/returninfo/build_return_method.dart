import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanpackage/contstants/app_strings.dart';
import 'package:scanpackage/contstants/colors.dart';
import 'package:scanpackage/data/retrun_shipping.dart';
import 'package:url_launcher/url_launcher.dart'; 

import 'build_shipping_address.dart';


Widget buildReturnMethod(ReturnShipping returnShipping) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: double.infinity, 
        child: Card(
          elevation: 0, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), 
            side: const BorderSide(color: lightGreyBorder, width: 1), 
          ),
          color: Colors.white, 
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gradient header
                Text(
                  AppStrings.returnMethodInfo,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text('${AppStrings.status}: ${returnShipping.status}',
                    style: GoogleFonts.roboto(fontSize: 16)),
                Text('${AppStrings.carrier}: ${returnShipping.carrier}',
                    style: GoogleFonts.roboto(fontSize: 16)),
                Text('${AppStrings.trackingNumber}: ${returnShipping.trackingNumber}',
                    style: GoogleFonts.roboto(fontSize: 16)),
                Text('${AppStrings.price}: \$${returnShipping.price.toStringAsFixed(2)}',
                    style: GoogleFonts.roboto(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),

      const SizedBox(height: 16),
      SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: lightGreyBorder, width: 1), // Soft grey border
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.returnMethod,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text('${AppStrings.returnMethod}: ${returnShipping.returnMethod}',
                    style: GoogleFonts.roboto(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 16),
      SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: lightGreyBorder, width: 1), // Soft grey border
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.shippingAddress,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                buildShippingAddress(returnShipping.from),
              ],
            ),
          ),
        ),
      ),

      const SizedBox(height: 16),
      SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: lightGreyBorder, width: 1), 
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.destinationAddress,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                buildShippingAddress(returnShipping.to),
              ],
            ),
          ),
        ),
      ),

      const SizedBox(height: 16),
      SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.blueGrey.shade100, width: 1), // Soft grey border
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.shippingInfo,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (await canLaunch(returnShipping.downloadLink)) {
                      await launch(returnShipping.downloadLink); // Launch the download link
                    } else {
                      throw 'Could not launch ${returnShipping.downloadLink}';
                    }
                  },
                  icon: const Icon(Icons.download),
                  label: const Text(AppStrings.downloadShippingInfo),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent, // Icon/text color
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
