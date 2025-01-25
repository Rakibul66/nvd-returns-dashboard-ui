import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanpackage/contstants/app_strings.dart';
import 'package:scanpackage/contstants/image_path.dart';

Widget buildNoDocumentsSection() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    color: Colors.white,
    child: Center(
      child: Column(
        children: [
          Image.asset(
            ImagePaths.docFile,
            width: 130,
            height: 130,
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.noDocs,
            style: GoogleFonts.roboto(
              color: const Color(0xFF9A9A9A),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.otherDetails,
            style: GoogleFonts.roboto(
              color: const Color(0xFF9A9A9A),
              fontSize: 10,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
