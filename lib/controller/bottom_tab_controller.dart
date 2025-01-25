import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;
  final PageController pageController = PageController();

  void changeTab(int index) {
    selectedIndex.value = index; // Update selected index
    // Remove jumpToPage, as it is managed by the PageView's onPageChanged callback
  }

  void onPageChanged(int index) {
    selectedIndex.value = index; // Update selected index when page changes
  }
}
