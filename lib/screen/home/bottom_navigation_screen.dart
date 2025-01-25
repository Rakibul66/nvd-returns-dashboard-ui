import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scanpackage/controller/bottom_tab_controller.dart';

import 'package:scanpackage/contstants/colors.dart';

import 'package:scanpackage/screen/history/history_screen.dart';
import 'package:scanpackage/screen/profile/profile_screen.dart';
import 'package:scanpackage/screen/queue/return_queue_screen.dart';
import 'package:scanpackage/screen/scan/scan_screen.dart';
import '../home/home_screen.dart';

class BottomNavScreen extends StatelessWidget {
  final BottomNavController bottomNavController =
      Get.put(BottomNavController());

  BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(() => PageView(
            controller: bottomNavController.pageController,
            onPageChanged: bottomNavController.onPageChanged,
            physics: const NeverScrollableScrollPhysics(), // Disable page swipe
            children: [
              HomeScreen(),
              ReturnQueueScreen(),
              HistoryScreen(),
              ProfileScreen(),
            ],
          )),
      bottomNavigationBar: Container(
        height: 81, // Set the height of the bottom navigation bar
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, 'assets/svg/home.svg', 'Home'),
            _buildNavItem(1, 'assets/svg/return.svg', 'Queue'),
            SizedBox(width: 24), // Spacer
            _buildNavItem(2, 'assets/svg/history.svg', 'History'),
            _buildNavItem(3, 'assets/svg/profile.svg', 'Profile'),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 45), // Adjust top padding
        child: GestureDetector(
          onTap: () {
            Get.to(
              () => ScanScreen(),
              transition: Transition.downToUp, // Apply the transition animation
              duration:
                  Duration(milliseconds: 400), // Adjust the duration as needed
            );
          },
          child: Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              color: primaryRedColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: const Offset(0, 4), // Vertical shadow
                  blurRadius: 4,
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/scan_white.svg', // Path to your SVG asset
                width: 34, // Adjust the size as needed
                height: 34, // Adjust the size as needed
                color: Colors.white, // Ensure the icon is white
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String assetPath, String label) {
    return Obx(() {
      bool isSelected = bottomNavController.selectedIndex.value == index;

      return InkWell(
        onTap: () {
          bottomNavController.changeTab(index);
          bottomNavController.pageController.jumpToPage(index);
        },
        borderRadius: BorderRadius.circular(
            24), // Optional: Add a border radius for ripple effect
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 8.0, horizontal: 16.0), // Increase tappable area
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the items vertically
            children: [
              SvgPicture.asset(
                assetPath,
                color: isSelected ? Colors.red : Colors.black,
                width: 24.0, // Fixed icon size
              ),
              const SizedBox(height: 4), // Space between icon and label
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.red : Colors.black,
                  fontSize: 12, // Adjust font size
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
