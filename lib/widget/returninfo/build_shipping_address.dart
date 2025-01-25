import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanpackage/contstants/app_strings.dart';
import 'package:scanpackage/data/address.dart';


Widget buildShippingAddress(Address address) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('${AppStrings.name}: ${address.name}', style: GoogleFonts.roboto(fontSize: 16)),
      Text('${AppStrings.street}: ${address.street1}', style: GoogleFonts.roboto(fontSize: 16)),
      if (address.street2.isNotEmpty)
        Text('${AppStrings.street2}: ${address.street2}', style: GoogleFonts.roboto(fontSize: 16)),
      Text('${AppStrings.city}: ${address.city}', style: GoogleFonts.roboto(fontSize: 16)),
      Text('${AppStrings.state}: ${address.state}', style: GoogleFonts.roboto(fontSize: 16)),
      Text('${AppStrings.country}: ${address.country}', style: GoogleFonts.roboto(fontSize: 16)),
      Text('${AppStrings.zip}: ${address.zip}', style: GoogleFonts.roboto(fontSize: 16)),
      Text('${AppStrings.phone}: ${address.phone}', style: GoogleFonts.roboto(fontSize: 16)),
    ],
  );
}
