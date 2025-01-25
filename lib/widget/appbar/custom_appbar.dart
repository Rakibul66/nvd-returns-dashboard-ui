import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scanpackage/contstants/app_strings.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double fontSizeLarge = MediaQuery.of(context).size.width * 0.06; // Responsive font size for title
    final double fontSizeSmall = MediaQuery.of(context).size.width * 0.03; // Responsive font size for subtitle

    return AppBar(
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipOval(
          child: Image.asset(
            'assets/doodle.png', // Replace with your actual asset path
            fit: BoxFit.cover,
            width: 40, // Width of the circular avatar
            height: 40, // Height of the circular avatar
          ),
        ),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, User", // Replace "User" with the actual user's name if needed
                style: TextStyle(
                  fontSize: fontSizeLarge,
                  fontWeight: FontWeight.w500,
                  color: Colors.black, // Set text color to black
                ),
              ),
              Text(
                "Welcome to ${AppStrings.appName}",
                style: TextStyle(
                  fontSize: fontSizeSmall,
                  fontWeight: FontWeight.w400,
                  color: Colors.black, // Set text color to black
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            'assets/svg/bell.svg', // Replace with your actual SVG asset path
            color: Colors.black, // Set SVG icon color to black for consistency
            height: 24,
            width: 24,
          ),
          onPressed: () {
            // Define the action here, such as opening a drawer or navigation
          },
        ),
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFD0F1EB),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
