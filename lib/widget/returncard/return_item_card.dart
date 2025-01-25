import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanpackage/contstants/colors.dart';
import 'package:scanpackage/contstants/image_path.dart';

import '../../screen/inspect/inspect_screen.dart';

class ReturnItemCard extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final double price;
  final String resolution;
  final String reason;
  final String customerNote;
  final int quantity;
  final String metaValue;
  final List<Widget> options;
  final int index;
  final int totalLength;
  final int itemId;
  final int? logisticsAnswerCount;
  final String shopUrl;

  const ReturnItemCard({
    super.key,
    required this.title,
    this.imageUrl,
    required this.price,
    required this.resolution,
    required this.reason,
    this.customerNote = "",
    required this.quantity,
    required this.metaValue,
    required this.options,
    required this.index,
    required this.totalLength,
    required this.itemId,
    this.logisticsAnswerCount,
    required this.shopUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl != null && imageUrl!.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: lightGreyBorder),
                  ),
                  child: Image.network(
                    imageUrl!,
                    width: 80,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        ImagePaths.scanner,
                        width: 80,
                        height: 90,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      );
                    },
                  ),
                ),
              if (imageUrl != null && imageUrl!.isNotEmpty)
                const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 6.0,
                      runSpacing: 6.0,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '',
                                style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: '\$${price.toStringAsFixed(2)}',
                                style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...options,
                        Text(
                          'Qty: $quantity',
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          resolution.capitalize!,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: _getResolutionColor(resolution),
                          ),
                        ),
                        ElevatedButton(
  onPressed: () {
    Get.to(() => InspectScreen(
          title: title,
          itemId: itemId,
          shopUrl: shopUrl,
        ));
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    elevation: 0,
    side: BorderSide(
      color: logisticsAnswerCount != null && logisticsAnswerCount! > 0
          ? Colors.green
          : redColor,
      width: 1,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  child: Text(
    logisticsAnswerCount != null && logisticsAnswerCount! > 0
        ? 'Inspected'
        : 'Inspect',
    style: GoogleFonts.inter(
      fontSize: 14,
      color: logisticsAnswerCount != null && logisticsAnswerCount! > 0
          ? Colors.green
          : primaryRedColor,
      fontWeight: FontWeight.bold,
    ),
  ),
),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (totalLength - 1 > index)
            Container(
              margin: const EdgeInsets.only(
                bottom: 5,
                top: 5,
              ),
              child: const Divider(
                color: lightGreyBorder,
              ),
            ),
        ],
      ),
    );
  }
}

Color _getResolutionColor(String resolution) {
  switch (resolution.toLowerCase()) {
    case 'exchange':
      return Colors.green;
    case 'swap':
      return Colors.orange;
    case 'refund':
      return Colors.red;
    default:
      return Colors.black;
  }
}
