import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:scanpackage/controller/connectivity_controller.dart';
import 'package:scanpackage/controller/user_controller.dart';
import 'package:scanpackage/contstants/colors.dart';
import 'package:scanpackage/contstants/image_path.dart';
import 'package:scanpackage/screen/auth/login_screen.dart';
import 'package:scanpackage/screen/home/bottom_navigation_screen.dart';
import 'package:scanpackage/screen/home/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final UserController userController = Get.put(UserController());
  final ConnectivityController connectivityController = Get.put(ConnectivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Obx(() {
          // Check for internet connectivity
          if (connectivityController.connectionStatus.value == 'Offline') {
            // Show offline Lottie animation
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  ImagePaths.splashLottie,
                  width: 150.w,
                  height: 150.h,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 20),
                const Text(
                  'No Internet',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            );
          } else {
            // If online, check onboarding status
            _checkOnboardingSeen();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImagePaths.appLogo,
                  width: 100.w, // Responsive width using ScreenUtil
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  // Method to check if onboarding has been seen and navigate accordingly
  void _checkOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    bool onboardingSeen = prefs.getBool('onboardingSeen') ?? false;

    Future.delayed(const Duration(seconds: 2), () {
      if (onboardingSeen) {
  Get.off(() => BottomNavScreen(),
              transition: Transition.fadeIn,
              duration: const Duration(seconds: 1));
      } else {
        Get.off(() => const OnboardingScreen(),
            transition: Transition.fadeIn,
            duration: const Duration(seconds: 1));
      }
    });
  }
}
