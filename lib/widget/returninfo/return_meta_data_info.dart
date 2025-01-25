import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanpackage/contstants/app_strings.dart';
import 'package:scanpackage/contstants/colors.dart';
import 'package:scanpackage/contstants/image_path.dart';
import 'package:scanpackage/widget/returncard/return_item_card.dart';

import '../../data/rma_data.dart';

Widget buildReturnItems(List<ReturnVariant> returnVariants) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        width: 1,
        color: lightGreyBorder,
      ),
    ),
    child: ExpansionTile(
      initiallyExpanded: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        side: BorderSide.none,
      ),
      tilePadding: const EdgeInsets.symmetric(horizontal: 12),
      childrenPadding: const EdgeInsets.only(
        bottom: 16,
      ),
      title: const Text(AppStrings.returnItems),
      children: [
        const Divider(
          color: lightGreyBorder,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: returnVariants.asMap().entries.map((entry) {
            int index = entry.key;
            var variant = entry.value; 
        

            // Use the provided image URL or fallback to the asset image if invalid
            final imageUrl = (variant.productInfoMeta?.image != null &&
                    variant.productInfoMeta!.image.isNotEmpty)
                ? variant.productInfoMeta!.image
                : ImagePaths.appLogo;

            final title = variant.productInfoMeta?.title ?? 'Unknown Product';

            // Get the first meta value to display
            String metaValue = variant.meta?.metaValue.isNotEmpty == true
                ? variant.meta!.metaValue[0]
                : 'N/A'; // Fallback if no meta value is available

            List<Widget> optionWidgets = [];
            if (variant.productInfoMeta?.options != null) {
              for (var option in variant.productInfoMeta!.options) {
                // Access the name from the option
                String optionName = option['name'] ?? 'Unknown Option';

                // Check if 'value' is a list or a single string
                var optionValues = option['value'];
                List<String> optionValueList;

                if (optionValues is List) {
                  optionValueList = List<String>.from(optionValues);
                } else if (optionValues is String) {
                  optionValueList = [
                    optionValues
                  ]; // Wrap single string in a list
                } else {
                  optionValueList = []; // Default to an empty list if neither
                }

                optionWidgets.add(
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$optionName: ',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      for (var value in optionValueList)
                        Text(
                          value,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                );
              }
            }

            return ReturnItemCard(
              title: title,
              imageUrl: imageUrl,
              price: variant.price,
              reason: variant.reason,
              quantity: variant.quantity,
              resolution: variant.resolution,
              options: optionWidgets, 
              metaValue: metaValue,
              index: index,
              totalLength:
                  returnVariants.length, 
                      itemId: variant.id,       
              shopUrl: variant.shopUrl,  
              logisticsAnswerCount: variant.logisticAnswersCount,

            );
          }).toList(),
        ),
      ],
    ),
  );
}
