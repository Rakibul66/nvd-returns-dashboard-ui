import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerCard extends StatelessWidget {
  const BannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 123.h,
      decoration: BoxDecoration(
        color: Colors.white, // Background color matching fillColor
        borderRadius: BorderRadius.circular(16), // 16 dp corner radius
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left-side image
              Container(
                width: 130.w,
                height: 130.h,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/coins.png'), // Replace with your actual image path
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              SizedBox(width: 16.w), // Space between image and text
              
              // Right-side content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Your balance",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "\$7,065.00",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet, // Wallet icon
                          color: Colors.grey[600],
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        const Text(
                          "Wallet",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_back_ios, // iOS back icon
                          color: Colors.grey[600],
                          size: 18.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
