import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCategoryCard("Send", "assets/mail_send.png", const Color(0xFFDED2F9)),
          const SizedBox(width: 8),
          _buildCategoryCard("Request", "assets/request.png", const Color(0xFFD3E1FF)),
          const SizedBox(width: 8),
          _buildCategoryCard("More", "assets/options.png", const Color(0xFFFDC9D2)),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String text, String iconPath, Color backgroundColor) {
    return Expanded(
      child: Container(
        height: 132.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular icon background with an asset icon inside
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  iconPath,
                  color: Colors.black,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            const SizedBox(height: 12), // Spacing between icon and text
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
