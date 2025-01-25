import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OnboardingController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController controller;
  late Animation<double> textAnimation;
  late Animation<double> imageAnimation;

  @override
  void onInit() {
    super.onInit();
    // Initialize the animation controller
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Define animations for text and image
    textAnimation = Tween<double>(begin: -100.0, end: 0.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));

    imageAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));

    // Start the animations when the screen loads
    controller.forward();
  }

  @override
  void onClose() {
    controller.dispose(); // Clean up the controller
    super.onClose();
  }
}
